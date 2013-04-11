require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::QueryBuilder do
  before :each do
    @builder = MassInsert::QueryBuilder.new([], {})
  end

  subject{ @builder }

  describe "instance methods" do
    describe "#initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @builder = MassInsert::QueryBuilder.new(@values, @options)
      end

      it "should initialize the values attribute" do
        @builder.values.should eq(@values)
      end

      it "should initialize the options attribute" do
        @builder.options.should eq(@options)
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end
    end

    describe "adapter" do
      it "should respond to adapter method" do
        subject.respond_to?(:adapter).should be_true
      end
    end

    describe "adapter_instance_class" do
      it "should respond to adapter_instance_class method" do
        subject.respond_to?(:adapter_instance_class).should be_true
      end

      context "when adapter is mysql" do
        it "should return a Mysql Adapter instance" do
          subject.stub(:adapter).and_return("mysql")
          instance_class = MassInsert::Adapters::MysqlAdapter
          subject.adapter_instance_class.class.should be(instance_class)
        end
      end

      context "when adapter is mysql2" do
        it "should return a Mysql2 Adapter instance" do
          subject.stub(:adapter).and_return("mysql2")
          instance_class = MassInsert::Adapters::MysqlAdapter
          subject.adapter_instance_class.class.should be(instance_class)
        end
      end
    end
  end
end