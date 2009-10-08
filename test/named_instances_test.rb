require 'test_helper'

class NamedInstancesTest < Test::Unit::TestCase
  context "Named instances of an AR model" do

    should "be able get instances" do
      result = Diagnosis.get(:diabetes_mellitus)
      assert_equal Diagnosis.find_by_name("Diabetes Mellitus"), result
    end

    should "reload after a save" do
      Diagnosis.get(:diabetes_mellitus)
      new_behavior = Diagnosis.create(:name=>"test1")

      result = Diagnosis.get(:test1)
      assert_equal new_behavior, result
    end

    should "raise an error if it doesn't exist at all" do
      assert_raise ArgumentError do
        Diagnosis.get(:test2)
      end
    end

    should "find deleted instances as well" do
      Diagnosis.get(:diabetes_mellitus).destroy
      Diagnosis.load_named_instances

      assert Diagnosis.get(:diabetes_mellitus)
    end

    should "maintain the same class object id on get" do
      result = Diagnosis.get(:diabetes_mellitus)
      assert_equal Diagnosis.object_id, result.class.object_id
    end

    should "return the method used for naming" do
      assert_equal(:name, Diagnosis.name_method)
    end

    should "accept an array of naming methods" do
      Foo = Struct.new(:bar, :baz)
      Foo.send(:include, NamedInstances)

      foo1 = Foo.new("abc", "def")
      foo2 = Foo.new("xyz", "zzz")

      Foo.expects(:after_save)
      Foo.expects(:all).returns([foo1, foo2])

      Rails.cache.expects(:write).with("named_instances_NamedInstancesTest::Foo_abc_def", foo1)
      Rails.cache.expects(:write).with("named_instances_NamedInstancesTest::Foo_xyz_zzz", foo2)

      Foo.has_named_instances [:bar, :baz]
      assert Foo.load_named_instances
    end

    should "not crash if the instances can't be loaded immediately" do
      BadFoo = Struct.new(:bar, :baz)
      BadFoo.send(:include, NamedInstances)

      BadFoo.expects(:after_save)
      BadFoo.expects(:all).raises(Exception)

      BadFoo.has_named_instances [:bar, :baz]
      assert_match /exception/, BadFoo.load_named_instances
    end

  end
end
