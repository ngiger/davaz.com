#!/usr/bin/env ruby
# View::TopNavigation -- davaz.com -- 19.07.2005 -- mhuggler@ywesee.com

require 'htmlgrid/divcomposite'
require 'htmlgrid/div'
require 'htmlgrid/divcomposite'
require 'view/maillink'
require 'htmlgrid/span'
require 'htmlgrid/ulcomposite'
require 'htmlgrid/spancomposite'
require 'view/composite'

module DAVAZ
	module View
		class NavigationComposite < HtmlGrid::SpanComposite
			COMPONENTS = {}
			CSS_CLASS = 'navigation'
			NAV_LINK_CSS = 'navigation'
			NAV_METHOD = :navigation
			SYMBOL_MAP = {
				:pipe_divider	=>	HtmlGrid::Text,
			}
			def init
				build_navigation()
				super
			end
			def build_navigation
				@link_idx = 0
				@zone_links = @lookandfeel.send(self::class::NAV_METHOD)
				puts @zone_links.inspect
				@zone_links.each_with_index { |ary, idx| 
					puts idx
					puts ary.inspect
					pos = [idx*2,0]
					components.store(pos, :navigation_link)
					components.store([idx*2-1,0], 'pipe_divider') if idx > 0
				}
			end
			def navigation_link(model)
				zone, event = *(@zone_links.at(@link_idx))
				@link_idx += 1
				if(event.nil?)
					self.send(zone, model)
				else
					link = HtmlGrid::Link.new(event, model, @session, self)
					link.href = @lookandfeel.event_url(zone, event)
					if(@session.event && @session.event == event)
						link.css_class = self::class::CSS_CLASS + "-active"
					else
						link.css_class = self::class::CSS_CLASS 
					end
					link
				end
			end
			def email_link(model) 
				link = DAVAZ::View::MailLink.new(:contact_email, model, @session, self)
				link.mailto = @lookandfeel.lookup(:email_juerg)
				link.css_class = self::class::CSS_CLASS 
				link
			end
		end
		module TopNavigationModule
			class Composite < View::NavigationComposite 
				CSS_CLASS = "top-navigation"
				NAV_METHOD = :top_navigation
			end
		end
		class InitTopNavigation < HtmlGrid::DivComposite 
			CSS_CLASS = "top-navigation"
			COMPONENTS = {
				[0,0]	=>	TopNavigationModule::Composite,
			}
		end
		class TopNavigation < View::NavigationComposite 
			CSS_CLASS = "top-navigation"
			NAV_METHOD = :top_navigation
		end
		class FootNavigation < View::NavigationComposite 
			CSS_CLASS = 'foot-navigation'
			NAV_METHOD = :foot_navigation
=begin
			COMPONENTS = {
				0	=>	:guestbook,
				1	=>	'pipe_divider',
				2	=>	:shop,
				3	=>	'pipe_divider',
				4	=>	:email_link,
				5	=>	'pipe_divider',
				6	=>	:news,
				7	=>	'pipe_divider',
				8	=>	:links,
				9	=>	'pipe_divider',
				10	=>	:home,
			}
			def email_link(model) 
				link = DAVAZ::View::MailLink.new(:contact_email, model, @session, self)
				link.mailto = @lookandfeel.lookup(:email_juerg)
				link.css_class = 'foot-navigation'
				link
			end
			def home(model)
				link = HtmlGrid::Link.new(:home, model, @session, self)
				link.href = @lookandfeel.event_url(:personal, :home)
				link.css_class = 'foot-navigation'
				link
			end
			def guestbook(model)
				link = HtmlGrid::Link.new(:guestbook, model, @session, self)
				link.href = @lookandfeel.event_url(:communication, :guestbook)
				link.css_class = 'foot-navigation'
				link
			end
			def links(model)
				link = HtmlGrid::Link.new(:links, model, @session, self)
				link.href = @lookandfeel.event_url(:communication, :links)
				link.css_class = 'foot-navigation'
				link
			end
			def news(model)
				link = HtmlGrid::Link.new(:news, model, @session, self)
				link.href = @lookandfeel.event_url(:communication, :news)
				link.css_class = 'foot-navigation'
				link
			end
			def shop(model)
				link = HtmlGrid::Link.new(:shop, model, @session, self)
				link.href = @lookandfeel.event_url(:communication, :shop)
				link.css_class = 'foot-navigation'
				link
			end
=end
		end
		class LeftNavigation < HtmlGrid::UlComposite 
			CSS_ID = 'left-navigation'
			COMPONENTS = { }
			def init
				@evt = @session.event
				links = [
					:drawings, :paintings, :multiples, :movies, :photos,
					:design, :schnitzenthesen, :empty_link
				]
				@small_links = [ 
					:gallery, :articles, :lectures, :exhibitions
				]
				links.concat(@small_links).each_with_index { |key, idx|
					components.store(idx, key)
					css_id = key.to_s
					css_class = 'left-navigation'
					zone = @session.zone
					if(@evt == key)
						css_id << '-active'
					elsif(key == :gallery && zone == :gallery && @evt == :home)
						css_id << '-active'
					end
					if(@small_links.include?(key))
						css_class << '-small'
					end
					css_id_map.store(idx, css_id)
					css_map.store(idx, css_class)
				}
				super
			end
			def drawings(model)
				navigation_link(model, :works, :drawings)
			end
			def paintings(model)
				navigation_link(model, :works, :paintings)
			end
			def multiples(model)
				navigation_link(model, :works, :multiples)
			end
			def movies(model)
				navigation_link(model, :works, :movies)
			end
			def photos(model)
				navigation_link(model, :works, :photos)
			end
			def design(model)
				navigation_link(model, :works, :design)
			end
			def schnitzenthesen(model)
				navigation_link(model, :works, :schnitzenthesen)
			end
			def empty_link(model)
				''
			end
			def gallery(model)
				link = HtmlGrid::Link.new(:gallery, model, @session, self)
				link.href = @lookandfeel.event_url(:gallery, :home)
				css = 'small-lnavlink'
				if(@session.zone == :gallery && @evt == :home)
					css << '-active'
				end
				link.css_class = css
				link.css_id = 'gallery'
				link.value = @lookandfeel.lookup(:gallery) 
				link
			end
			def articles(model)
				navigation_link(model, :public, :articles)
			end
			def lectures(model)
				navigation_link(model, :public, :lectures)
			end
			def exhibitions(model)
				navigation_link(model, :public, :exhibitions)
			end
			def navigation_link(model, zone, key)
				link = HtmlGrid::Link.new(key, model, @session, self)
				link.href = @lookandfeel.event_url(zone, key)
				css = if(@small_links.include?(key))
					'small-lnavlink'
				else
					'lnavlink'
				end
				if(@evt == key)
					css << '-active'
				end
				link.css_class = css
				link.css_id = key.to_s
				link.value = @lookandfeel.lookup(key) 
				link
			end
		end
		class GalleryNavigation < HtmlGrid::SpanComposite
			CSS_CLASS = 'gallery-navigation'
			COMPONENTS = {
				#[0,0]	=>	:gallery,
				#[1,0]	=>	'pipe_divider',
			}
			def init
				@model = @session.app.load_artgroups
				build_navigation()
				super
			end
			def gallery(model)
				link = HtmlGrid::Link.new(:gallery, model, @session, self)
				args = [
					[ :search_query, @session.user_input(:search_query) ],
				]
				link.href = @lookandfeel.event_url(:gallery, :search, args)
				link.css_class = self::class::CSS_CLASS 
				link
			end
			def build_navigation
				#@link_idx = 2
				@link_idx = 0
				@model.each_with_index { |event, idx| 
					#idx += 1
					pos = [idx*2,0]
					components.store(pos, :navigation_link)
					if(idx > 0 && idx != 7)
						components.store([idx*2-1,0], 'pipe_divider')
					else
						components.store([idx*2-1,0], 'br')
					end
				}
			end
			def navigation_link(model)
				artgroup = @model.at(@link_idx-2).name.downcase
				artgroup_id = @model.at(@link_idx-2).artgroup_id
				@link_idx += 1
				link = HtmlGrid::Link.new(artgroup.intern, model, @session, self)
				args = [
					[ :artgroup_id, artgroup_id ]
				]
				link.href = @lookandfeel.event_url(:gallery, :search, args)
				link.css_class = self::class::CSS_CLASS 
				link
			end
		end
	end
end
