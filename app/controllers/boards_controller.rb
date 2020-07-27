 class BoardsController < ApplicationController
   before_action :set_target_board, only: %i[show edit update destroy]

   def index
     @boards = Board.all
   end

   def new
     @board = Board.new
   end 
   def create
     board = Board.create(board_params)

     redirect_to board #このboardには１０行目でidが付与されている、なのでredirect時にもidが効く
   end

   def show
     
   end

   def edit
     
   end

   def update
     
     board.update(board_params)

     redirect_to @board
   end

   def destroy
   	 #特定のIDに対して行うアクションなので、findがいる
   	 @board.delete

   	 redirect_to boards_path
   end

   private

   def board_params
     params.require(:board).permit(:name, :title, :body)
   end

   def set_target_board
   	 @board = Board.find(params[:id])
   end
 end
