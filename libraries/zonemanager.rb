module EtWorker
  class ZoneManager
    def initialize(zone, credentials)
      @new_zone_data = zone['data']
      @zone_id = zone['id']
      @credentials = credentials
    end

    def updated
      @new_zone_data - current_zone_data
    end

    def removed
      names_and_types(sanitize(current_zone_data)) -
        names_and_types(@new_zone_data)
    end

    private

    def sanitize(zone_data)
      illegal_types = %w(SOA NS)
      zone_data.reject { |r| illegal_types.include? r['type'] }
    end

    def names_and_types(zone_data)
      zone_data.map { |r| { 'name' => r['name'], 'type' => r['type'] } }
    end

    def credentials_opts
      return { use_iam_profile: true } if @credentials['use_iam_profile']

      {
        aws_access_key_id: @credentials['access_key_id'],
        aws_secret_access_key: @credentials['secret_access_key']
      }
    end

    def connection
      @connection ||= begin
        gem 'fog-aws', '>= 0.7'
        require 'fog/aws'
        ::Fog::DNS::AWS.new credentials_opts
      end
    end

    def names(zone_data)
      zone_data.map { |r| r['name'] }
    end

    def current_zone_data
      data = JSON.parse(connection.zones.get(@zone_id).records.to_json)
      data.each { |r| r['name'].sub!(/\.$/, '') }
    end
  end
end
