# -*- coding: utf-8 -*-
class Package < ActiveRecord::Base
  attr_accessible :name, :category_id, :affiliations_attributes

  has_many :affiliations, :dependent => :destroy
  has_many :templates, :through => :affiliations
  belongs_to :category

  accepts_nested_attributes_for :affiliations,
    :allow_destroy => true,
    :reject_if => lambda {|attrs| attrs[:template_id].blank?}
  # 実装しろ
end
