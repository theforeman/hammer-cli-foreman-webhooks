# frozen_string_literal: true

module HammerCLIForemanWebhooks
  module CommandExtensions
    class Webhook < HammerCLI::CommandExtensions
      option '--ssl-ca-certs', 'PATH_TO_CA_FILE',
             _('File containing X509 Certification Authorities concatenated in PEM format'),
             format: HammerCLI::Options::Normalizers::File.new
      option '--http-headers', 'HTTP_HEADERS', '',
             format: HammerCLI::Options::Normalizers::KeyValueList.new

      before_print do |data|
        data['http_headers'] = http_headers_from_json(data['http_headers'])
      end

      request_params do |params|
        if params['webhook']['http_headers']
          params['webhook']['http_headers'] = http_headers_to_json(params['webhook']['http_headers'])
        end
      end

      def self.http_headers_to_json(headers)
        return headers unless headers.is_a?(Hash)

        require 'json'
        JSON.dump(headers)
      end

      def self.http_headers_from_json(data)
        return data unless data.is_a?(String)

        require 'json'
        begin
          JSON.parse(data).each_pair.each_with_object([]) do |(key, value), result|
            result << { name: key, value: value }
          end
        rescue JSON::ParserError
          [{}]
        end
      end
    end
  end
end
