#!/usr/bin/env ruby
# View::Personal::Init -- davaz.com -- 18.07.2005 -- mhuggler@ywesee.com

require 'view/form'
require 'view/publictemplate'
require 'view/composite'
require 'view/works/oneliner'
require 'view/ticker' 
require 'view/maillink'
require 'htmlgrid/divcomposite'
require 'htmlgrid/image'
require 'htmlgrid/link'
require	'htmlgrid/urllink'
require 'htmlgrid/div'

module DAVAZ
	module View
		module Personal 
class IntroText < HtmlGrid::Div
	CSS_CLASS = "intro-text"
	def init
		super
		@value = @lookandfeel.lookup(:intro_text)
	end
end
class Signature < HtmlGrid::Div
	CSS_CLASS = "signature"
	def init 
		super
		img = HtmlGrid::Image.new(:signature, model, @session, self)
		link = HtmlGrid::Link.new(:signature, model, @session, self)
		link.href = @lookandfeel.event_url(:personal, :work)
		link.value = img
		@value = link
	end
end
class PhotoDavaz < HtmlGrid::Div
	CSS_CLASS = "photo"
	CSS_ID = 'photo_davaz'
	def init 
		super
		img = HtmlGrid::Image.new(:photo_davaz, model, @session, self)
		args = [ :display_id, 'Power' ]
		@dojo_tooltip = @lookandfeel.event_url(:tooltip, :tooltip_poem, args)
		@value = img
	end
end
class PicInspiration < HtmlGrid::Div
	CSS_CLASS = 'pic-inspiration' 
	def init 
		super
		img = HtmlGrid::Image.new(:pic_inspiration, model, @session, self)
		link = HtmlGrid::Link.new(:pic_inspiration, model, @session, self)
		link.href = @lookandfeel.event_url(:personal, :inspiration)
		link.value = img
		@value = link
	end
end
class PicFamily < HtmlGrid::Div
	CSS_CLASS = 'pic-family' 
	def init 
		super
		img = HtmlGrid::Image.new(:pic_family, model, @session, self)
		link = HtmlGrid::Link.new(:pic_family, model, @session, self)
		link.href = @lookandfeel.event_url(:personal, :family)
		link.value = img
		@value = link
	end
end
class PicBottleneck < HtmlGrid::Div
	CSS_CLASS = 'pic-bottleneck' 
	CSS_ID = 'pic_bottleneck'
	def init 
		super
		img = HtmlGrid::Image.new(:pic_bottleneck, model, @session, self)
		args = [ :display_id, 'Bottleneck' ]
		@dojo_tooltip = @lookandfeel.event_url(:tooltip, :tooltip_poem, args)
		@value = img
	end
end
class Copyright < HtmlGrid::Div
	CSS_CLASS = 'init-copyright'
	def init 
		super
		link = HtmlGrid::HttpLink.new(:copyright, model, @session, self)
		link.href = @lookandfeel.lookup(:ywesee_url)
		link.css_class = 'copyright-link'
		@value = link
	end
end
class CommunicationLinksComposite < View::Composite
	CSS_CLASS = 'communication-links'
	COMPONENTS = {
		[0,0]	=>	:news,
		[0,1]	=>	:links,
		[0,2]	=>	:email,
		[0,3]	=>	:gallery,
		[0,4]	=>	:movies,
		[0,5]	=>	:guestbook,
		
	}
	CSS_MAP = {
		[0,0]	=>	'communication-links',
		[0,1]	=>	'communication-links',
		[0,2]	=>	'communication-links',
		[0,3]	=>	'communication-links',
		[0,4]	=>	'communication-links',
	}
	def news(model)
		link = HtmlGrid::Link.new(:news, model, @session, self)
		link.href = @lookandfeel.event_url(:communication, :news)
		link.css_class = 'communication-link'
		link
	end
	def links(model)
		link = HtmlGrid::Link.new(:links, model, @session, self)
		link.href = @lookandfeel.event_url(:communication, :links)
		link.css_class = 'communication-link'
		link
	end
	def email(model)
		link = DAVAZ::View::MailLink.new(:contact_email, model, @session, self)
		link.mailto = @lookandfeel.lookup(:email_juerg)
		link.css_class = 'communication-link'
		link
	end
	def gallery(model)
		link = HtmlGrid::Link.new(:gallery, model, @session, self)
		link.href = @lookandfeel.event_url(:communication, :gallery_search)
		link.css_class = 'communication-link'
		link
	end
	def movies(model)
		link = HtmlGrid::Link.new(:movies, model, @session, self)
		link.href = @lookandfeel.event_url(:communication, :movies)
		link.css_class = 'communication-link'
		link
	end
	def guestbook(model)
		link = HtmlGrid::Link.new(:guestbook, model, @session, self)
		link.href = @lookandfeel.event_url(:communication, :guestbook)
		link.css_class = 'communication-link'
		link
	end
end
class MoviePage < HtmlGrid::Div
	CSS_CLASS = 'movie-page display-inline'
	def init
		super
		link = HtmlGrid::Link.new(:movie_page, model, @session, self)
		link.href = @lookandfeel.event_url(:works, :movies)
		link.value = @lookandfeel.lookup(:movie_page)
		link.css_class = 'movie-page'
		@value = link
	end
end
class PlayerDownload < HtmlGrid::DivComposite
	CSS_CLASS = 'player-download'
	COMPONENTS = {
		[0,0]	=>	'player_download_text',
		[1,0]	=>	'nbsp',	
		[2,0]	=>	:realplayer_download,
		[3,0]	=>	'slash_divider',
		[4,0]	=>	:quicktime_download,
	}
	def realplayer_download(model)
		link = HtmlGrid::HttpLink.new(:realone_player, model, @session, self)
		link.href = @lookandfeel.lookup(:realplayer_download)
		link.css_class = 'realplayer-download'
		link
	end
	def quicktime_download(model)
		link = HtmlGrid::HttpLink.new(:quicktime_player, model, @session, self)
		link.href = @lookandfeel.lookup(:quicktime_download)
		link.css_class = 'quicktime-download'
		link
	end
end
class MovieLinks < HtmlGrid::DivComposite
	CSS_CLASS = 'movie-links'
	COMPONENTS = {
		[0,0]	=>	:movie_ticker_link,
		[1,0]	=>	:movie_page,
	}
	def movie_ticker_link(model)
		link = HtmlGrid::Link.new(:movie_ticker, model, @session, self)
		link.href = "javascript:void(0)"
		link.attributes['onclick'] = "toggleTicker();"		
		link.value = @lookandfeel.lookup(:movie_link)  
		link.css_class = 'movies-div-link'
		link
	end
	def movie_page(model)
		link = HtmlGrid::Link.new(:movie_page, model, @session, self)
		link.href = @lookandfeel.event_url(:works, :movies)
		link.value = @lookandfeel.lookup(:movie_page)
		link.css_class = 'movie-page'
		link
	end
end
class CommunicationLinks < HtmlGrid::DivComposite
	CSS_CLASS = 'communication-links'
	COMPONENTS = {
		[0,0]	=>	CommunicationLinksComposite,
	}
end
class Drawing < HtmlGrid::DivComposite
	CSS_CLASS = "drawing"
	COMPONENTS = {
		[0,0]	=>	:drawing,
	}
	def drawing(model) 
		img = HtmlGrid::Image.new(:init_drawing, model, @session, self)
		img 
	end
end
class PayPalForm < View::Form
	COMPONENTS = {
		[0,0]	=>	:donation_logo,
	}
	FORM_ACTION = 'https://www.paypal.com/cgi-bin/webscr'
	def donation_logo(model)
		image = HtmlGrid::Input.new(:submit, model, @session, self)
		image.attributes['src'] = @lookandfeel.resource(:paypal_donate)
		image.attributes['type'] = 'image'
		image.attributes['border'] = '0'
		image.attributes['alt']	= "Make payments with PayPal - it's fast, free and secure!"
		image
	end
	def hidden_fields(context)
		''<<
		context.hidden('cmd', '_xclick')<<
		context.hidden('business', 'juerg@davaz.com')<<
		context.hidden('item_name','Donation For The Da Vaz Foundation.')<<
		context.hidden('no_note','1')<<
		context.hidden('currency_code', 'EUR')<<
		context.hidden('tax', '0')<<
		context.hidden('lc','US')<<
		context.hidden('bn','PP-DonationsBF')
	end
end
class PayPalButtonDiv < HtmlGrid::DivComposite
	CSS_ID = 'paypal-button'
	COMPONENTS = {
		[0,0]	=>	PayPalForm,
	}
end
class PayPalDiv < HtmlGrid::DivComposite
	CSS_ID = 'paypal'
	COMPONENTS = {
		[0,0]	=>	PayPalButtonDiv,
	}
end
class OneLiner < HtmlGrid::Div
	CSS_ID = 'oneliner'
	def init
		super
		model = @session.app.load_oneliner('index')
		@value = View::Works::OneLiner.new(model, @session, self)
	end
end
class InitComposite < HtmlGrid::DivComposite
	CSS_CLASS = 'init-container'
	COMPONENTS = {
		[0,0]		=>	Drawing,
		[1,0]		=>	PhotoDavaz,
		[2,0]		=>	Signature,
		[3,0]		=>	IntroText,
		[4,0]		=>	PicInspiration,
		[5,0]		=>	PicFamily,
		[6,0]		=>	PicBottleneck,
		[7,0]		=>	CommunicationLinks,
		[8,0]		=>	Copyright,
		[9,0]		=>	OneLiner,
		[10,0]	=>	MovieLinks,
		[11,0]	=>	PlayerDownload,
		[12,0]	=>	PayPalDiv,
	}
end
class Init < View::PublicTemplate
	CSS_FILES = [ :navigation_css, :init_css ]
	COMPONENTS = {
		[0,0]	=>	View::TopNavigation,
		[0,1]	=>	:ticker,
		[0,2]	=>	InitComposite,
	}
	CSS_ID_MAP = {
		0	=>	'top-navigation',
		1	=>	'ticker-container',
	}
	CSS_MAP = {}
	def other_html_headers(context)
		args = {
			'language'	=>	'JavaScript',
			'type'			=>	'text/javascript',
		}
		super << context.script(args) {
			<<-EOS
			function scrollDiv(elId) {
				var node = document.getElementById(elId);
				dojo.fx.html.slideTo(node, [-#{@model.size * self.class.const_get(:MOVIES_DIV_IMAGE_WIDTH)},0], #{@model.size * self.class.const_get(:MOVIES_DIV_IMAGE_SPEED)})
			}
			EOS
		}
	end
	def ticker(model)
		model = @session.app.load_movies
		@value = View::Ticker.new(model, @session, self)	
	end
end
		end
	end
end
