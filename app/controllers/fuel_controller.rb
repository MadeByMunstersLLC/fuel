class FuelController < ApplicationController

  helper_method :s3_bucket

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def not_found_error(exception)
    # render json: {error: "not-found"}.to_json, status: 404
    respond_to do |format|
      format.html
      format.json { render json: {error: "not-found"}.to_json, status: 404 }
    end
  end

  def s3_bucket
    return nil unless Fuel.configuration.aws_bucket.present?
    @s3_bucket ||= (
      AWS::S3.new.buckets[Fuel.configuration.aws_bucket]
    )
  end

  def self.paginated_action(options={})
    before_filter(options) do |controller|

      # Set defaults
      @pagination_current_page = params[:page] ? params[:page] : 1
      @pagination_per_page = nil

      if Fuel.configuration.header_pagination && request.headers['Range-Unit'] == 'items' && request.headers['Range'].present?
        if request.headers['Range'] =~ /(\d+)-(\d*)/
          requested_from, requested_to = $1.to_i, ($2.present? ? $2.to_i : Float::INFINITY)
        end

        # TODO: Improve invalid range handling
        @pagination_per_page = requested_to - requested_from + 1
        @pagination_current_page = requested_to / @pagination_per_page + 1
      end
    end

    after_filter(options) do |controller|
      results = instance_variable_get("@#{controller_name}")
      if (results.length > 0)
        response.status = 206
        headers['Accept-Ranges'] = 'items'
        headers['Range-Unit'] = 'items'

        total_items = results.total_count
        current_page = results.current_page
        per = @pagination_per_page || total_items

        requested_from = (results.current_page - 1) * per
        available_to = (results.length - 1) + requested_from

        headers['Content-Range'] = "#{requested_from}-#{available_to}/#{total_items < Float::INFINITY ? total_items : '*'}"
      else
        response.status = 204
        headers['Content-Range'] = '*/0'
      end
    end
  end

end