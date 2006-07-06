#!/usr/bin/env ruby
# View::Gallery::Home -- davaz.com -- 28.09.2005 -- mhuggler@ywesee.com

require 'view/publictemplate'
require 'htmlgrid/divcomposite'
require 'htmlgrid/spanlist'
require 'view/add_onload_show'
require 'view/serie_widget'
require 'view/serie_links'
require 'view/works/oneliner'

module DAVAZ
	module View
		module Gallery 
class SearchTitle < HtmlGrid::Div
	CSS_CLASS = 'table-title center'
	def init
		super
		img = HtmlGrid::Image.new(:gallery_search_title, model, @session, self)
		@value = img 
	end
end
class SeriesTitle < HtmlGrid::Div
	CSS_CLASS = 'table-title center'
	def init
		super
		img = HtmlGrid::Image.new(:series_title, model, @session, self)
		@value = img 
	end
end
class InputBar < HtmlGrid::InputText
	def init
		super
		val = @lookandfeel.lookup(@name)
		@attributes.update({
			'id'			=>	"searchbar",
		})
		args = [@name, '']
		submit = @lookandfeel.event_url(:gallery, :search, args)
		script = "if(#{@name}.value!='#{val}'){"
		script << "var href = '#{submit}'"
		script << "+escape(#{@name}.value.replace(/\\//, '%2F'));"
		script << "document.location.href=href; } return false"
		self.onsubmit = script
	end
end
class SearchBar < HtmlGrid::Form
	CSS_CLASS = 'center'
	COMPONENTS = {
		[0,0]	=>	:search_query,
		[0,1]	=>	:submit,
		[1,1]	=>	:search_reset,
	}
	COLSPAN_MAP = {
		[0,0]	=>	2,
	}
	SYMBOL_MAP = {
		:search_query			=>	InputBar,	
	}
	EVENT = :search
	FORM_METHOD = 'POST'
	def init
		self.onload = "document.getElementById('searchbar').focus();"
		super
	end
	def search_reset(model, session)
		button = HtmlGrid::Button.new(:search_reset, model, session, self)
		button.set_attribute("type", "reset")
		button
	end
end
class UpperHomeComposite < HtmlGrid::DivComposite
	CSS_ID = 'upper-search-composite'
	COMPONENTS = {
		[0,0]	=>	SearchTitle,
		[0,1]	=>	View::GalleryNavigation,
		[0,2]	=>	SearchBar,
		[0,3]	=>	component(View::Works::OneLiner, :oneliner),
		[0,4]	=>	SeriesTitle,
	}
	CSS_ID_MAP = {
		0	=>	'search-title',
		2	=>	'search-bar',
		3	=>	'search-oneliner',
	}
end
class HomeComposite < HtmlGrid::DivComposite
	CSS_ID = 'inner-content'
	COMPONENTS = {
		[0,0]	=>	UpperHomeComposite,
		[0,1]	=>	:slideshow_rack,
		[0,2]	=>	component(GallerySerieLinks, :series),
		[0,3] =>	View::AddOnloadShow,
	}
	CSS_STYLE_MAP = {
		1	=>	'display:none;',
	}
	CSS_ID_MAP = {
		0	=>	'upper-search-composite',
		1	=>	'show-wipearea',
		2	=>	'serie-links',
	}
	def slideshow_rack(model)
		GallerySlideShowRackComposite.new([], @session, self)
	end
end
class Home < View::GalleryPublicTemplate
	CONTENT = View::Gallery::HomeComposite 
end
		end
	end
end
