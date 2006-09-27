#!/usr/bin/env ruby
# Util::DavazApp -- davaz.com -- 26.08.2005 -- mhuggler@ywesee.com

require 'yus/session'
require 'util/updater'

module DAVAZ
	module Util
		class DavazApp
			attr_accessor :db_manager
			def initialize
				if(DAVAZ.config.run_updater)
					run_updater
				end
			end
			def run_updater
				day = 24 * 60 * 60
				Thread.new {
					Thread.current.priority=-5
					Thread.current.abort_on_exception = false 
					loop {
						sleep(day - (Time.now.to_i % day))
						Updater.new(self).run
					}
				}
			end
			def add_element(link_id, artobject_id)
				@db_manager.add_element(link_id, artobject_id)
			end
			def add_link(artobject_id, link_word)
				@db_manager.add_link(artobject_id, link_word)
			end
			def add_serie(serie_name)
				@db_manager.add_serie(serie_name)
			end
			def add_tool(tool_name)
				@db_manager.add_tool(tool_name)
			end
			def add_material(material_name)
				@db_manager.add_material(material_name)
			end
			def store_upload_image(image_file, artobject_id)
				Util::ImageHelper.store_upload_image(image_file, artobject_id)
			end
			def count_serie_artobjects(serie_id)
				@db_manager.count_artobjects('serie_id', serie_id)
			end
			def count_tool_artobjects(tool_id)
				@db_manager.count_artobjects('tool_id', tool_id)
			end
			def count_material_artobjects(material_id)
				@db_manager.count_artobjects('material_id', material_id)
			end
			def delete_artobject(artobject_id)
				@db_manager.delete_artobject(artobject_id)
			end
			def delete_guest(guest_id)
				@db_manager.delete_guest(guest_id)
			end
			def delete_image(artobject_id)
				Util::ImageHelper.delete_image(artobject_id)
			end
			def delete_link(link_id)
				@db_manager.delete_link(link_id)
			end
			def enc2utf8(str)
				Iconv.iconv('utf8', 'latin1', str).first
			end
			def insert_artobject(values_hash)
				@db_manager.insert_artobject(values_hash)
			end
			def insert_guest(values_hsh)
				@db_manager.insert_guest(values_hsh)
			end
			def load_artgroup_artobjects(artgroup_id)
				@db_manager.load_artobjects_by_artgroup(artgroup_id)
			end
			def load_artgroups
				@db_manager.load_artgroups
			end
			def load_articles
        @db_manager.load_serie_artobjects('site_articles', 'series.name')
			end
			def load_article(artobject_id)
				@db_manager.load_artobject(artobject_id)
			end
			def load_artobject(artobject_id, select_by='artobject_id')
				@db_manager.load_artobject(artobject_id, select_by)
			end
			def load_country(id)
				@db_manager.load_country(id)
			end
			def load_countries
				@db_manager.load_countries
			end
			def load_currency_rates(model)
				@db_manager.load_currency_rates(model)
			end
			def load_images_by_tag(tag_name)
				@db_manager.load_images_by_tag(tag_name)
			end
			def load_exhibitions
				@db_manager.load_serie_artobjects('site_exhibitions', 'series.name')
			end
			def load_thefamily_text
				@db_manager.load_serie_artobjects('site_thefamily', 'series.name')
			end
			def load_guest(guest_id)
				@db_manager.load_guest(guest_id)
			end
			def load_guests
				@db_manager.load_guests
			end
			def load_hisfamily_text
				@db_manager.load_serie_artobjects('site_hisfamily', 'series.name')
			end
			def load_hisinspiration_text
				@db_manager.load_serie_artobjects('site_hisinspiration', 'series.name')
			end
			def load_hislife(lang)
				@db_manager.load_serie_artobjects("site_life_#{lang}", 'series.name')
			end
			def load_hiswork_text
				@db_manager.load_serie_artobjects('site_hiswork', 'series.name')
			end
			def load_image_tags
				@db_manager.load_image_tags
			end
			def load_links
				@db_manager.load_serie_artobjects('site_links', 'series.name')
			end
			def load_lectures
				@db_manager.load_serie_artobjects('site_lectures', 'series.name')
			end
			def load_material(id)
				@db_manager.load_material(id)
			end
			def load_materials
				@db_manager.load_materials
			end
			def load_news
				@db_manager.load_serie_artobjects('site_news', 'series.name')
			end
			def load_oneliner(location)
				@db_manager.load_oneliner(location)
			end
			def load_serie(serie_id, select_by='serie_id')
				@db_manager.load_serie(serie_id, select_by)
			end
			def load_serie_id(name)
				@db_manager.load_serie_id(name)
			end
			def load_series
				@db_manager.load_series("", load_artobjects=false)
			end
			def load_series_by_artgroup(artgroup_id)
				@db_manager.load_series_by_artgroup(artgroup_id)
			end
=begin
			def load_serie_objects(table_class, artgroup_id, serie_id)
				@db_manager.load_serie_objects(table_class, artgroup_id, serie_id)
			end
=end
			def load_shop_artgroups
				@db_manager.load_artgroups('shop_order')
			end
			def load_shop_items
				@db_manager.load_shop_items
			end
			def load_shop_item(id)
				@db_manager.load_shop_item(id)
			end
			def load_tags
				@db_manager.load_tags
			end
			def load_tag_artobjects(tag)
				@db_manager.load_tag_artobjects(tag)
			end
			def load_tool_artobject_id(tool_id)
				@db_manager.load_element_artobject_id('tool_id', tool_id)
			end
			def load_tools
				@db_manager.load_tools
			end
			def load_movie(id)
				@db_manager.load_movie(id)
			end
			def load_movies
				@db_manager.load_movies
			end
			def load_movies_ticker
				@db_manager.load_artobject_ids('MOV')
			end
			def load_multiples
				@db_manager.load_artobjects_by_artgroup('MUL')
			end
			def login(email, pass)
				DAVAZ.yus_server.login(email, pass, DAVAZ.config.yus_domain)
			end
			def logout(yus_session)
				DAVAZ.yus_server.logout(yus_session)
			end
			def remove_element(artobject_id, link_id)
				@db_manager.remove_element(artobject_id, link_id)
			end
			def remove_serie(serie_id)
				@db_manager.remove_serie(serie_id)
			end
			def remove_tool(tool_id)
				@db_manager.remove_tool(tool_id)
			end
			def remove_material(material_id)
				@db_manager.remove_material(material_id)
			end
			def search_artobjects(query, artgroup_id)
				if(query.nil? || query.empty?)
					@db_manager.load_artobjects_by_artgroup(artgroup_id)
				else
					@db_manager.search_artobjects(query)
				end
			end
			def update_artobject(artobject_id, update_hash)
				@db_manager.update_artobject(artobject_id, update_hash)
			end
			def update_guest(guest_id, update_hash)
				@db_manager.update_guest(guest_id, update_hash)
			end
		end
	end
end
