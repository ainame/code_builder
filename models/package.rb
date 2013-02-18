# -*- coding: utf-8 -*-
require_relative 'active_record/act_as_random_id'

class Package < ActiveRecord::Base
  include ActiveRecord::ActAsRandomId
  attr_accessor :category
  attr_accessible :name, :category_id, :templates_attributes
  has_many :affiliations, :dependent => :destroy
  has_many :templates, :through => :affiliations
  has_many :builder_enviroments
  scope :latest, order('created_at desc')
  accepts_nested_attributes_for :templates, :allow_destroy => true

  def category
    @category ||= Category.new(self.category_id)
  end

  def have_persisted_templates?
    self.templates.first && self.templates.first.persisted?
  end

  def update_attributes(params)    
    update_attributes_for_delete params
    super params
  end

  private
  def update_attributes_for_delete(params)
    before_ids = self.templates.map(&:id).map(&:to_s)
    after_ids  = params[:templates_attributes].map do |number,template|
      template[:id]
    end
    delete_target_ids = before_ids - after_ids
    
    delete_target_ids.each do |id|
      Affiliation.delete(id)
    end
  end
end
