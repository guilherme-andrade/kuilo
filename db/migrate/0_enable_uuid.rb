# frozen_string_literal: true

class EnableUuid < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE EXTENSION pgcrypto WITH SCHEMA pg_catalog;'
  end
end
