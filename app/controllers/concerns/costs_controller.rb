class CostsController < ApplicationController
  def show
    @cost = Cost.new(cost_params)

    if @cost.invalid?
      return render plain: "Error\n" + @cost.errors.full_messages.join("\n"),
                    status: :unprocessable_entity
    end

    price = @cost.calculate_shipping

    if price
      render plain: price, status: :ok
    else
      render plain: "Error\nNo valid route between #{@cost.origin} and #{@cost.destination}",
             status: :unprocessable_entity
    end
  end

  private

  def cost_params
    params.permit :origin, :destination, :weight
  end
end
