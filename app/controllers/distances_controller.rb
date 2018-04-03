class DistancesController < ApplicationController
  def create
    @distance = Distance.new.parse_raw_post(request.raw_post)

    if @distance.errors.empty? && @distance.save
      render plain: 'OK',
             status: :ok
    else
      render plain: "Error\n" + @distance.errors.full_messages.join("\n"),
             status: :unprocessable_entity
    end
  end
end
