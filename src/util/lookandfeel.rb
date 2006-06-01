#!/usr/bin/env ruby
# Util::Lookandfeel -- davaz.com -- 18.07.2005 -- mhuggler@ywesee.com

require 'sbsm/lookandfeel'
require 'util/davazconfig'
require 'yaml'
require 'iconv'

module DAVAZ
	module Util
		class Lookandfeel < SBSM::Lookandfeel
			LANGUAGES = [
				'en'
			]
			def base_url(zone=@session.zone)
				[@session.http_protocol + ':/', @session.server_name, @language, zone].compact.join("/")
			end
			DICTIONARIES = {
				'en'	=>	{
					:a_divider								=>	'&nbsp;&aacute;&nbsp;',
					:add_entry								=>	'Submit Entry',
					:address									=>	'Address',
					:articles									=>	'Articles',
					:back											=>	'<< Back',
					:bottleneck								=>	'Bottleneck',
					:change_of_times					=>	'Change of Times<br>1990 - 2000',
					:contact_email						=>	'Email',
					:chinese									=>	'Chinese',
					:city											=>	'City',
					:close_article						=>  'Close Article',	
					:close_window							=>  'Close Window',	
					:close_window_href				=>  'javascript:window.close()',	
					:comma_divider						=>	',&nbsp;',
					:copyright								=>	'&copy;DaVaz 2005',
					:country									=>	'Country',
					:dash_divider							=>	'&nbsp;-&nbsp;',
					:date											=>	'Date',
					:davaz_guestbook					=>	'The Da Vaz Guestbook',
					:davaz_shop								=>	'The Da Vaz Shop',
					:design										=>	'Design',
					:drawings									=>	'Drawings',
					:e_domainless_email_address	=>	'Sorry, but your email-address seems to be invalid. Please try again.',
					:e_invalid_email_address	=>	'Sorry, but your email-address seems to be invalid. Please try again.',
					:e_invalid_postal_code		=>	'Your Postal Code seems to be invalid.',
					:e_invalid_serie_id				=>	'Sorry that is an invalid serie_id.',
					:e_invalid_zone						=>	'Sorry that is an invalid zone.',
					:e_missing_fields					=>	'Please fill out the fields that are marked with red.',	
					:early_years							=>	'Early Years<br>1946-1957',
					:email										=>	'Email',
					:email_juerg							=>	'juerg@davaz.com',
					:english									=>	'English',
					:equal_divider						=>	'&nbsp;=&nbsp;',
					:exhibitions							=>	'Exhibitions',
					:eyesharpener							=>	'Eyesharpener',
					:family										=>	'HIS FAMILY',
					:family_of_origin					=>	'His Family of Origin',
					:gallery									=>	'Gallery',
					:gallery_search						=>	'Gallery',
					:guestbook								=>	'Guestbook',
					:guestbook_info						=>	'Please add your comments.<br>I greatly appreciate your opinion and further information.<br><br>Thank you!',
					:heartbeat								=>	'Heartbeat',
					:hide											=>  'Hide',	
					:history_back_link				=>	'<a href=\'javascript:history.go(-1)\'  onMouseOver=\'self.status=document.referrer;return true\'>go back</a>',
					:home											=>	'Home',
					:html_title								=>	'Da Vaz - Abstract Artist from Switzerland',
					:hungarian								=>	'Hungarian',
					:hunting									=>	'Hunting',
					:imagination							=>	'Imagination',
					:india_ticker_link				=>	'Passage through India: One of Da Vaz\'s memorable trips',
					:init_drawing							=>	'Drawing',
					:inspiration							=>	'HIS INSPIRATION',
					:intro_text								=>	' Swiss-born artist Da Vaz does not wait for the right<br>moment. He could be totally unprepared himself when his<br>adrenaline surges up. His searching eyes look for details<br>from where he culls new meanings, new expressions.<br>And give life to his indigenous art form.',
					:item_s										=>	'Item(s)',
					:items_in_cart						=>	'Item(s) in Cart',
					:journey									=>	'Journey',
					:lectures									=>	'Lectures',
					:life											=>	'HIS LIFE',
					:links										=>	'Links',
					:links_from_davaz					=>	'Links from Da Vaz',
					:messagetxt								=>	'Message',
					:more											=>	'more...',
					:morphopolis_ticker_link		=>	'MOVIE:   M O R P H O P O L I S, Da Vaz`s outstanding vision of PublicSpace',
					:movies										=>	'Movies',
					:movie_link								=>	':: watch :: eyesharpener Da Vaz movies',
					:name											=>	'Name',
					:nbsp											=>	'&nbsp',
					:new_entry								=>	'New Entry',
					:new_guestbook_entry			=>	'New Guestbook Entry',
					:news											=>	'News',
					:news_from_davaz					=>	'News from Da Vaz',
					:next											=>	'Next >>',
					:no_name									=>	'',
					:no_works									=>	'There are no works in this category yet.',
					:order_item								=>	'Order Item(s)',
					:paintings								=>	'Paintings',
					:photos										=>	'Photos',
					:photo_davaz							=>	'Photo of J&uuml;rg Davaz',
					:pic_bottleneck						=>	'Link to Bottleneck',
					:pic_family								=>	'Link to Family',
					:pic_inpiration						=>	'Link to Inpiration',
					:pipe_divider							=>	'&nbsp;|&nbsp;',
					:player_download_text			=>	'free download:',
					:posters									=>	'Posters',
					:private_life							=>	'Private Life<br>1975 - 1989',
					:publications							=>	'Publications',
					:quicktime_player					=>	'Quicktime player',
					:quicktime_download				=>	'http://www.apple.com/quicktime/download/',	
					:read_on									=>	'Read On...',
					:realone_player						=>	'RealOne player',
					:realplayer_download			=>	'http://europe.real.com/freeplayer_r1p.html?&src=ZG.eu.idx.idx.sw.chc',
					:remove_all_items					=>	'remove all items',
					:remove_item							=>	'remove item',
					:russian									=>	'Russian',
					:schnitzenthesen					=>	'Schnitzenthesen',
					:send_order								=>	'Send Order',
					:shop											=>	'Shop',
					:shop_mail_salut					=>	"Hi!\n\nThe following order has been sent:",
					:shop_mail_bye						=>	"Thank you very much for your interest in my site and your order.\n\nWith best regards\n\nJ. Davatz",
					:shop_thanks							=>	'Your order has been succesfully sent.<br>Thank you very much.',
					:shopping_cart						=>	'Shopping Cart',
					:signature								=>	'Signature',
					:slash_divider						=>	'&nbsp;/&nbsp;',
					:space_divider						=>	'&nbsp;',
					:street										=>	'Street',
					:surname									=>	'Surname',
					:text											=>	'Text',
					:th_artgroup							=>	'Artgroup',
					:th_count									=>	'Item(s)',
					:th_dollars								=>	'&agrave; $',
					:th_franks								=>	'&agrave; CHF',
					:th_name									=>	'Item',
					:th_subtotal_dollars			=>	'Subtotal $',
					:th_subtotal_franks				=>	'Subtotal CHF',
					:the_family								=>	'THE FAMILY',
					:the_family_title					=>	'The Family',
					:title_divider						=>	' | ',
					:time_of_change						=>	'Times of Change<br>1965 - 1975',
					:times_divider						=>	'&nbsp;x&nbsp;',
					:total										=>	'TOTAL',
					:update										=>	'Submit',
					:movie_page								=>	' ::  movie page',
					:movie										=>	'Movie',
					:movies										=>	'Movies',
					:multiples								=>	'Multiples',
					:work											=>	'HIS WORK',
					:ywesee_url								=>	'http://www.ywesee.com',
					:postal_code							=>	'Postal Code',
				}
			}
			RESOURCES = {
				:articles_css			=>	'css/articles.css',
				:css							=>	'css/davaz.css',
				:communication_css	=>	'css/communication.css',
				:design_css				=>	'css/design.css',
				:desk							=>	'images/global/desk.gif',
				:dojo_js					=>	'dojo/dojo.js',
				:drawings_css			=>	'css/drawings.css',
				:exhibitions_css	=>	'css/exhibitions.css',
				:family_title			=>	'images/global/family.gif',
				:images_css				=>	'css/images.css',
				:init_css					=>	'css/init.css',
				:init_drawing			=>	'images/init/drawing.jpg',
				:inspiration_title	=>	'images/global/inspiration.gif',
				:javascript				=>	'javascript',
				:lectures_css			=>	'css/lectures.css',
				:logo_ph					=>	'images/global/DaVaz_logo_ph.gif',
				:multiples_css		=>	'css/multiples.css',
				:navigation_css		=>	'css/navigation.css',
				:paintings_css		=>	'css/paintings.css',
				:paypal_donate		=>	'images/global/paypal_donate.gif',
				:pause						=>	'images/global/pause.gif',
				:personal_css			=>	'css/personal.css',
				:photo_davaz			=>	'images/init/photo_davaz.jpg',
				:photos_css				=>	'css/photos.css',
				:pic_bottleneck		=>	'images/init/bottleneck.jpg',
				:pic_family				=>	'images/init/family.jpg',
				:pic_inspiration	=>	'images/init/inspiration.jpg',
				:play							=>	'images/global/play.gif',
				:play_large_movie	=>	'images/global/large_movie.png',
				:play_small_movie	=>	'images/global/small_movie.png',
				:rack							=>	'images/global/rack.gif',
				:ram_files				=>	'movies/ram_files',
				:schnitzenthesen_css	=>	'css/schnitzenthesen.css',
				:show							=>	'images/global/show.gif',
				:signature				=>	'images/init/signature.GIF',
				:tooltip_css			=>	'css/tooltip.css',
				:topleft_ph				=>	'images/global/topleft_ph.gif',
				:movies_css				=>	'css/movies.css',
				:work_title				=>	'images/global/work.gif',
			}
			def event_url(zone=@session.zone, event=:home, args={})
				args = args.collect { |*pair| pair }.flatten
				arr = [base_url(zone), event]
				arr.push(args).compact.join('/')
			end
			def foot_navigation(filter=false)
				@session.foot_navigation
			end
=begin
			def paypal_encrypted_value
				<<-EOS
-----BEGIN
PKCS7-----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-----END
PKCS7-----
				EOS
			end
=end
			def resource_path(rname, rstr)
				dir = collect_resource([self::class::RESOURCE_BASE], rname, rstr)
				File.expand_path("../../doc" + dir, File.dirname(__FILE__))
			end
			def slideshow_directory(dir)
				File.join(PROJECT_ROOT, 'doc/resources/images/slideshows', dir)
			end
			def stream_url(id, size)
				filename = "#{id.to_s}_#{size.to_s.downcase}.ram"
				if(File.exist?(resource_path(:ram_files, filename)))
					arr = [resource_global(:ram_files), filename]	
					arr.compact.join('/')
				else
					nil
				end
			end
			def top_navigation(filter=false)
				@session.top_navigation
			end
			def set_dictionary(language)
				super
				@dictionary
			end
		end
	end
end
