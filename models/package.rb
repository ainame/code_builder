# -*- coding: utf-8 -*-
class Package < ActiveRecord::Base
  attr_accessible :name, :category_id, :affiliation_attributes

  belongs_to :affiliation
  belongs_to :category

  accepts_nested_attributes_for :affiliation,
    :allow_destroy => true,
    :reject_if => lambda {|attrs| attrs[:template_id].blank?}
  # 実装しろ
end
