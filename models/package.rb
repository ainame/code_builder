# -*- coding: utf-8 -*-
require_relative 'active_record/act_as_random_id'

class Package < ActiveRecord::Base
  include ActiveRecord::ActAsRandomId
  
  attr_accessible :name, :category_id, :templates_attributes
  has_many :affiliations, :dependent => :destroy
  has_many :templates, :through => :affiliations
  belongs_to :category
  has_many :builder_enviroments
  scope :latest, order('created_at desc')

  accepts_nested_attributes_for :templates, :allow_destroy => true
end
