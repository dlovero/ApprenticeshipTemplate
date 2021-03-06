class BoardController < ApplicationController

  def put_mark
    board_found = Board.find(board_id.to_i)
    board_found.put_mark_on(mark_coordinates)
    render json: board_found, status: :ok
  end

  private

  def board_id
    params.require(:id)
  end

  def mark_coordinates
    params.require(:position).permit(:x, :y)
    {y: params[:position][:y].to_i,x: params[:position][:x].to_i}
  end

end
