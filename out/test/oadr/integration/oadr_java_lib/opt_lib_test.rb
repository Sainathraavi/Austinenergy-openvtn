#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# Copyright (c) 2013, Electric Power Research Institute (EPRI)
# All rights reserved.
#
# OpenADR ("this software") is licensed under BSD 3-Clause license.
#
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice, this 
#    list of conditions and the following disclaimer.
#    
#  * Redistributions in binary form must reproduce the above copyright notice, 
#    this list of conditions and the following disclaimer in the documentation 
#    and/or other materials provided with the distribution.
#    
#  * Neither the name of EPRI nor the names of its contributors may 
#    be used to endorse or promote products derived from this software without 
#    specific prior written permission.#
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
# OF SUCH DAMAGE.
# 
# This EPRI software incorporates work covered by the following copyright and permission
# notices. You may not use these works except in compliance with their respective 
# licenses, which are provided below.
# 
# These works are provided by the copyright holders and contributors "as is" and any express or
# implied warranties, including, but not limited to, the implied warranties of merchantability
# and fitness for a particular purpose are disclaimed.
# 
#########################################################################################
# MIT Licensed Libraries
#########################################################################################
#
# * actionmailer 3.2.12 (http://www.rubyonrails.org) - Copyright (c) 2004-2011 David Heinemeier Hansson
# * actionpack 3.2.12 (http://www.rubyonrails.org) - 2004-2011 David Heinemeier Hansson
# * activemodel 3.2.12 (http://www.rubyonrails.org) - 2004-2011 David Heinemeier Hansson
# * activerecord 3.2.12 (http://www.rubyonrails.org) - 2004-2011 David Heinemeier Hansson
# * activeresource 3.2.12 (http://www.rubyonrails.org) - 2006-2011 David Heinemeier Hansson
# * activesupport 3.2.12 (http://www.rubyonrails.org) - Copyright (c) 2005-2011 David Heinemeier Hansson
# * arel 3.0.2 (http://github.com/rails/arel) - Copyright (c) 2007-2010 Nick Kallen, Bryan Helmkamp, Emilio Tagua, Aaron Patterson
# * builder 3.0.4 (http://onestepback.org) - Copyright (c) 2003-2012 Jim Weirich (jim.weirich@gmail.com)
# * bundler 1.3.5 (http://gembundler.com) - Portions copyright (c) 2010 Andre Arko, Portions copyright (c) 2009 Engine Yard
# * coffee-rails 3.2.2 () - Copyright (c) 2011 Santiago Pastorino
# * coffee-script-source 1.6.3 (http://jashkenas.github.com/coffee-script/) - Copyright 2011 Jeremy Ashkenas
# * edn 1.0.0 () - Copyright (c) 2012 Relevance Inc & Clinton N. Dreisbach
# * erubis 2.7.0 (http://www.kuwata-lab.com/erubis/) - copyright(c) 2006-2011 kuwata-lab.com all rights reserved.
# * execjs 1.4.0 (https://github.com/sstephenson/execjs) - Copyright (c) 2011 Sam Stephenson, Copyright (c) 2011 Josh Peek
# * gem-licenses 0.1.2 (http://github.com/dblock/gem-licenses) - Copyright (c) Daniel Doubrovkine, 2011 by Artsy, Inc.
# * hike 1.2.3 (http://github.com/sstephenson/hike) - Copyright (c) 2011 Sam Stephenson
# * i18n 0.6.5 (http://github.com/svenfuchs/i18n) - Copyright (c) 2008 The Ruby I18n team 
# * journey 1.0.4 (http://github.com/rails/journey) - Copyright (c) 2011 Aaron Patterson
# * jquery-rails 3.0.4 (http://rubygems.org/gems/jquery-rails) - Copyright [André Arko](http://arko.net)
# * mail 2.4.4 (http://github.com/mikel/mail) - Copyright (c) 2009, 2010, 2011, 2012
# * mime-types 1.23 (http://mime-types.rubyforge.org/) - Copyright 2003–2013 Austin Ziegler.
# * multi_json 1.7.9 (http://github.com/intridea/multi_json) - Copyright (c) 2010-2013 Michael Bleigh, Josh Kalderimis, Erik Michaels-Ober, Pavel Pravosud
# * rack-test 0.6.2 (http://github.com/brynary/rack-test) - Copyright (c) 2008-2009 Bryan Helmkamp, Engine Yard Inc.
# * railties 3.2.12 (http://www.rubyonrails.org) - copyright 2005 by Ryan Tomayko
# * rake 10.1.0 (http://rake.rubyforge.org) - Copyright (c) 2003, 2004 Jim Weirich
# * rspec 2.14.1 (http://github.com/rspec) - Copyright (c) 2009 Chad Humphries, David Chelimsky, Copyright (c) 2006 David Chelimsky, The RSpec Development Team Copyright (c) 2005 Steven Baker
# * rspec-core 2.14.3 (http://github.com/rspec/rspec-core) - Copyright (c) 2009 Chad Humphries, David Chelimsky, Copyright (c) 2006 David Chelimsky, The RSpec Development Team Copyright (c) 2005 Steven Baker
# * rspec-expectations 2.14.0 (http://github.com/rspec/rspec-expectations) - Copyright (c) 2006 David Chelimsky, The RSpec Development Team Copyright (c) 2005 Steven Baker
# * rspec-mocks 2.14.1 (http://github.com/rspec/rspec-mocks) - Copyright (c) 2006 David Chelimsky, The RSpec Development Team, Copyright (c) 2005 Steven Baker
# * rspec-rails 2.14.0 (http://github.com/rspec/rspec-rails) - Copyright (c) 2006 David Chelimsky, The RSpec Development Team
# * sass 3.2.9 (http://sass-lang.com/) - Copyright (c) 2006-2009 Hampton Catlin, Nathan Weizenbaum, and Chris Eppstein
# * sass-rails 3.2.6 () - Copyright (c) 2011 Christopher Eppstein
# * spork 1.0.0rc3 (http://github.com/sporkrb/spork) - Copyright (c) 2009 Tim Harper
# * therubyrhino 2.0.2 (http://github.com/cowboyd/therubyrhino) - Copyright (c) 2009-2012 Charles Lowell 
# * thor 0.18.1 (http://whatisthor.com/) - Copyright (c) 2008 Yehuda Katz, Eric Hodel, et al.
# * tilt 1.4.1 (http://github.com/rtomayko/tilt/) - Copyright (c) 2010 Ryan Tomayko <http://tomayko.com/about>
# * treetop 1.4.14 (https://github.com/cjheath/treetop) - Copyright (c) 2007 Nathan Sobo.
# * uglifier 2.1.2 (http://github.com/lautis/uglifier) - Copyright (c) 2011 Ville Lautanala
# * activerecord-jdbcpostgresql-adapter 1.2.9 (https://github.com/jruby/activerecord-jdbc-adapter) - Copyright (c) 2006-2007 Nick Sieger <nick@nicksieger.com>, Copyright (c) 2006-2007 Ola Bini <ola@ologix.com>
# * bcrypt-ruby 3.0.1 (http://bcrypt-ruby.rubyforge.org) - 
# * blankslate 2.1.2.4 (http://github.com/masover/blankslate) - Copyright 2004, 2006 by Jim Weirich (jim@weirichhouse.org)
# * choice 0.1.6 (http://choice.rubyforge.org/) - Copyright (c) 2006 Chris Wanstrath
# * coffee-script 2.2.0 (http://github.com/josh/ruby-coffee-script) - Copyright (c) 2010 Joshua Peek
# * diff-lcs 1.2.4 (http://diff-lcs.rubyforge.org/) - Copyright 2004–2013 Austin Ziegler.
# * jquery-ui-rails 4.0.3 (https://github.com/joliss/jquery-ui-rails) - Copyright (c) Jo Liss
# * jruby-rack 1.1.13.2 (http://jruby.org) - Copyright (c) 2012 Karol Bucek, Copyright (c) 2010-2012 Engine Yard, Inc.,Copyright (c) 2007-2009 Sun Microsystems, Inc.
# * parslet 1.4.0 (http://kschiess.github.com/parslet) - Copyright (c) 2010 Kaspar Schiess
# * rack 1.4.5 (http://rack.github.com/) - Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012 Christian Neukirchen
# * rack-cache 1.2 (http://tomayko.com/src/rack-cache/) - Copyright (c) 2008 Ryan Tomayko <http://tomayko.com/about> 
# * rack-ssl 1.3.3 (https://github.com/josh/rack-ssl) - Copyright (c) 2010 Joshua Peek
# * rails 3.2.12 (http://www.rubyonrails.org) - 
# * sprockets 2.2.2 (http://getsprockets.org/) - Copyright (c) 2011 Sam Stephenson, Copyright (c) 2011 Joshua Peek
# * tzinfo 0.3.37 (http://tzinfo.rubyforge.org/) - Copyright (c) 2005-2006 Philip Ross
# * warbler 1.4.0.beta1 (http://caldersphere.rubyforge.org/warbler) - Copyright (c) 2010-2013 Engine Yard, Inc., Warbler (c) 2007-2009 Sun Microsystems, Inc.
# * blueprint - (http://www.blueprintcss.org/) - Copyright © 2007 Olav Bjorkoy (http://bjorkoy.com)
#  
#########################################################################################
# BSD Licensed Libraries
#########################################################################################
#
# * activerecord-jdbc-adapter 1.2.9.1 (https://github.com/jruby/activerecord-jdbc-adapter) - Copyright (c) 2006-2012 Nick Sieger <nick@nicksieger.com>, Copyright (c) 2006-2008 Ola Bini <ola.bini@gmail.com> 
# * jdbc-postgres 9.2.1004 (https://github.com/jruby/activerecord-jdbc-adapter) - Copyright (c) 1997-2011, PostgreSQL Global Development Group
#
#########################################################################################
# Ruby Licensed Libraries
#########################################################################################
#
# * annotate 2.5.0 (http://github.com/ctran/annotate_models) - 
# * json 1.8.0 (http://json-jruby.rubyforge.org/) - 
# * rubyzip 0.9.9 (http://github.com/aussiegeek/rubyzip) - 
# * test-unit 2.5.5 (http://test-unit.rubyforge.org/) - Copyright (c) <kou@cozmixng.org>, Ryan Davis <ryand-ruby@zenspider.com>, and Nathaniel Talbott <nathaniel@talbott.ws>
# * httpclient 2.2.7 (http://github.com/nahi/httpclient) - Copyright (c) NAKAMURA, Hiroshi; Maehashi-san
#
#########################################################################################
# Public domain - creative commons Licensed Libraries
#########################################################################################
# 
# * torquebox 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-cache 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-configure 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-core 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-messaging 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-naming 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-rake-support 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-security 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-server 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-stomp 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-transactions 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
# * torquebox-web 3.0.0 (http://torquebox.org/) - Copyright 2008-2013 Red Hat, Inc, and individual contributors.
#
#########################################################################################
# Apache Licensed Libraries
#########################################################################################
#
# * bundler-unload 1.0.1 (https://github.com/mpapis/bundler-unload) - Copyright (c) 2013 Michal Papis
# * rubygems-bundler 1.2.2 (http://mpapis.github.com/rubygems-bundler) - Copyright (c) 2011-2012 Josh Hull and Michal Papis
#
#########################################################################################
# LGPL
#########################################################################################
#
# * jruby-1.7.4
# * jruby-jars 1.7.4 (http://github.com/jruby/jruby/tree/master/gem/jruby-jars) - The core JRuby code and the JRuby stdlib as jar 
# ** JRuby is tri-licensed GPL, LGPL, and EPL.
#
#########################################################################################
# MPL Licensed Libraries
#########################################################################################
#
# * therubyrhino_jar 1.7.4 (http://github.com/cowboyd/therubyrhino) - Rhino's jars packed for therubyrhino
#
#########################################################################################
# No License Given
#########################################################################################
#
# * spork-testunit 0.0.8 (http://github.com/timcharper/spork-testunit) - spork-testunit
#
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


require 'test_helper'
require 'integration/helpers/flow_helper'


java_import Java::epri.oadr2b.lib.OadrCreateOpt
java_import Java::epri.oadr2b.lib.OadrCreatedOpt
java_import Java::epri.oadr2b.lib.OadrCancelOpt
java_import Java::epri.oadr2b.lib.OadrCanceledOpt
java_import Java::epri.oadr2b.lib.EiTargetType
java_import Java::epri.oadr2b.lib.OptTypeType
java_import Java::epri.oadr2b.lib.OptReasonEnumeratedType
java_import Java::epri.oadr2b.lib.QualifiedEventID

java_import Java::epri.oadr2b.lib.xcal.Available
java_import Java::epri.oadr2b.lib.xcal.Properties
java_import Java::epri.oadr2b.lib.xcal.Properties::Tolerance
java_import Java::epri.oadr2b.lib.xcal.Properties::Tolerance::Tolerate
java_import Java::epri.oadr2b.lib.xcal.Dtstart
java_import Java::epri.oadr2b.lib.xcal.DurationPropType
java_import Java::epri.oadr2b.lib.xcal.Vavailability
java_import Java::epri.oadr2b.lib.xcal.ArrayOfVavailabilityContainedComponents

java_import javax.xml.datatype.XMLGregorianCalendar

class OptLibTest < ActionDispatch::IntegrationTest
  fixtures :accounts, :vens, :vtn_parameters, :signal_types, :response_required_types, :market_contexts

  include FlowHelper

  ########################################################

  def setup
    @ven = Ven.first

    registration = @ven.registrations.new
    registration.save

    @ven.registration = registration
    @ven.save
  end

  ########################################################

  def create_opt(opt_type, opt_reason)
    create_opt = OadrCreateOpt.new

    create_opt.opt_type = opt_type # OptTypeType::OPT_IN
    create_opt.opt_reason = opt_reason #OptReasonEnumeratedType::ECONOMIC.value
    create_opt.created_date_time = ZuluTime.get_gregorian_calendar_now

    create_opt.market_context = MarketContext.first.name

    # ven = Ven.first

    create_opt.ven_id = @ven.ven_id
    create_opt.ei_target = EiTargetType.new
    create_opt.ei_target.ven_ids.add(@ven.name)

    create_opt.request_id = SecureRandom.hex(10)

    create_opt
  end

  ########################################################

  def validate_opt_response(opt_request, created_opt, type)
    assert_true created_opt.kind_of?(type)

    assert_equal opt_request.request_id, created_opt.ei_response.request_id

    assert_equal '200', created_opt.ei_response.response_code
    assert_equal 'OK', created_opt.ei_response.response_description
  end

  ########################################################

  test "create opt in" do
    create_opt = create_opt(OptTypeType::OPT_IN, OptReasonEnumeratedType::ECONOMIC.value)

    # create_opt = OadrCreateOpt.new

    event = Event.new

    event.response_required_type = ResponseRequiredType.first
    event.duration = "PT60M"
    event.market_context = MarketContext.first

    Event.default_event(event, SignalName.first.id, SignalType.first.id)

    assert_true event.valid?

    event.publish

    #event.errors.full_messages.each do |error|
    #  puts error
    #end

    assert event.valid?

    create_opt.qualified_event_id = QualifiedEventID.new
    create_opt.qualified_event_id.event_id = event.event_id
    create_opt.qualified_event_id.modification_number = 0


    create_opt.ven_id = @ven.ven_id

    xml = Marshalling20b.instance.marshal_and_wrap(create_opt, 'set_oadr_create_opt')

    # puts xml

    assert_difference(['EventOpt.count', 'event.event_opts.count']) do
      post oadr20b_opt_path, xml
    end


    oadr_payload = Marshalling20b.instance.unmarshal(@response.body)

    created_opt = oadr_payload.oadr_signed_object.oadr_created_opt

    validate_opt_response(create_opt, created_opt, OadrCreatedOpt)

  end

  # TODO: test invalid VEN, Event, OptType, OptReason

  ########################################################

  test "create opt schedule" do

    create_opt = OadrCreateOpt.new
    create_opt = create_opt(OptTypeType::OPT_IN, OptReasonEnumeratedType::ECONOMIC.value)

    available = Available.new

    available.properties = Properties.new

    available.properties.dtstart = Dtstart.new
    available.properties.dtstart.date_time = ZuluTime.get_gregorian_calendar(Java::java.util.Date.new)
    available.properties.duration = DurationPropType.new
    available.properties.duration.duration = 'PT60M'

    available.properties.tolerance = Tolerance.new
    available.properties.tolerance.tolerate = Tolerate.new
    available.properties.tolerance.tolerate.startafter = 'PT5M'

    create_opt.vavailability = Vavailability.new
    create_opt.vavailability.components = ArrayOfVavailabilityContainedComponents.new
    create_opt.vavailability.components.availables.add(available)

    xml = Marshalling20b.instance.marshal_and_wrap(create_opt, 'set_oadr_create_opt')

    # puts xml

    assert_difference (['OptSchedule.count', 'OptScheduleDuration.count']) do
      post oadr20b_opt_path, xml
    end

    # puts @response.body

    opt_schedule = OptSchedule.find_by_opt_id(create_opt.opt_id)

    assert_true opt_schedule.active

    oadr_payload = Marshalling20b.instance.unmarshal(@response.body)

    created_opt = oadr_payload.oadr_signed_object.oadr_created_opt

    validate_opt_response(create_opt, created_opt, OadrCreatedOpt)

    # cancel the schedule
    cancel_opt = OadrCancelOpt.new

    cancel_opt.request_id = SecureRandom.hex(10)
    cancel_opt.opt_id = create_opt.opt_id
    cancel_opt.ven_id = @ven.ven_id

    xml = Marshalling20b.instance.marshal_and_wrap(cancel_opt, 'set_oadr_cancel_opt')

    post oadr20b_opt_path, xml

    # puts @response.body

    oadr_payload = Marshalling20b.instance.unmarshal(@response.body)

    canceled_opt = oadr_payload.oadr_signed_object.oadr_canceled_opt

    validate_opt_response(cancel_opt, canceled_opt, OadrCanceledOpt)

    opt_schedule.reload

    assert_false opt_schedule.active
  end

  ########################################################


end