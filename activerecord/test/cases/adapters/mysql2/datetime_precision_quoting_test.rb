# frozen_string_literal: true

require "cases/helper"

class Mysql2DatetimePrecisionQuotingTest < ActiveRecord::Mysql2TestCase
  setup do
    @connection = ActiveRecord::Base.connection
  end

  test "microsecond precision for MySQL gte 5.6.4" do
    stub_version "5.6.4" do
      assert_microsecond_precision
    end
  end

  test "no microsecond precision for MySQL lt 5.6.4" do
    stub_version "5.6.3" do
      assert_no_microsecond_precision
    end
  end

  test "microsecond precision for MariaDB gte 5.3.0" do
    stub_version "5.5.5-10.1.8-MariaDB-log" do
      assert_microsecond_precision
    end
  end

  test "no microsecond precision for MariaDB lt 5.3.0" do
    stub_version "5.2.9-MariaDB" do
      assert_no_microsecond_precision
    end
  end

  private
    def assert_microsecond_precision
      assert_match_quoted_microsecond_datetime(/\.000001\z/)
    end

    def assert_no_microsecond_precision
      assert_match_quoted_microsecond_datetime(/\d\z/)
    end

    def assert_match_quoted_microsecond_datetime(match)
      assert_match match, @connection.quoted_date(Time.now.change(usec: 1))
    end

    def stub_version(full_version_string)
      @connection.stub(:full_version, full_version_string) do
        @connection.remove_instance_variable(:@version) if @connection.instance_variable_defined?(:@version)
        yield
      end
    ensure
      @connection.remove_instance_variable(:@version) if @connection.instance_variable_defined?(:@version)
    end
end
