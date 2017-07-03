class EnquiryController < ApplicationController
  def index
  end

  def query

    # get text data
    data = params[:query].split(/\W+/)
    # words = data.split(/\W+/)
    call = ""
    src = ""
    dest = ""
    quota = ""
    train_no = ""
    pnr = ""
    data.each_with_index do |word,i|
      # look for keywords
        word = word.upcase
        puts word
        case word

        when "SEAT"
          call = "seat"

        when "FROM"
          src = data[i+1]
          call = "query"

        when "TO"
          dest = data[i+1]

        when "PNR"
          if data[i+1].upcase == "STATUS"
            pnr = data[i+2]
            call = "pnr"
          end

        when "TRAIN"
          if data[i+1].upcase == "NUMBER" || data[i+1].upcase == "NO"
            train_no = data[i+2]
          end

        when "LIVE"
          if data[i+1].upcase = "STATUS"
            call = "live"
          end

        when "FARE"
          call = "fare"

        when "GENERAL" || "TATKAL"
          quota = word

        end
    end

    #API call
    secret = "#{Rails.application.secrets[:api_key]}"
    # PNR url = "http://api.railwayapi.com/pnr_status/pnr/1234567890/apikey/myapikey/"
    # LIVE url = "http://api.railwayapi.com/live/train/12046/doj/20151119/apikey/myapikey/"
    # SEAT url = http://api.railwayapi.com/check_seat/train/12001/source/BPL/dest/NDLS/date/14-10-2014/class/CC/quota/GN/apikey/myapikey/
    # FARE url = http://api.railwayapi.com/fare/train/12555/source/gkp/dest/ndls/age/18/quota/PT/doj/23-11-2014/apikey/myapikey/
    # TRAINS B/W url = http://api.railwayapi.com/between/source/gkp/dest/ngp/date/27-08/apikey/myapikey/
    main_url = "http://api.railwayapi.com/"

    if call == "query"
      url = main_url + "between/source/#{src}/dest/#{dest}/date/#{Time.now.strftime("%m-%d-%Y")}/apikey/#{secret}/"
    end

    if call == "seat"
      url = main_url + "check_seat/train/#{train_no}/source/#{src}/dest/#{dest}/date/#{Time.now.strftime("%m-%d-%Y")}/class/CC/quota/#{quota}/apikey/#{secret}/"
    end

    puts url
    response = Unirest.get url
    @json = response.body
    # respond_to do |format|
      # format.json { render json: data }
    # end
  end
end
