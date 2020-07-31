 class BoardsController < ApplicationController
   before_action :set_target_board, only: %i[show edit update destroy]

   def index
     # @boards = Board.all
     @boards = Board.page(params[:page]) #ページネーション追加のため
   end

   def new
     @board = Board.new(flash[:board])
   end 

   def create
	 # board = Board.create(board_params)
	 board = Board.new(board_params)
	 if board.save
	   flash[:notice] = "『#{board.title}』の掲示板を作成しました"
	   redirect_to board
	 else
	   redirect_to new_board_path, flash: {
	  	 board: board,
	  	 error_messages: board.errors.full_messages
	   }
	 end  
	# flash[:notice] = "『#{board.title}』の掲示板を作成しました"
	# redirect_to board #このboardには１０行目でidが付与されている、なのでredirect時にもidが効く
   end

   def show
     #下記のコードでは、commentモデルからnewで作成する際、board_idで初期化する。コレであれば、boaed.idに紐づいたコメントには影響しない。
     @comment = Comment.new(board_id: @board.id)
     #下記のコードではnewメソッドで新しく作成された、保存されていないコメントがboard.commentに含まれて、@commentに空の投稿が入ってしまう。
     # @comment = @board.comments.new #board.comments(boardオブジェクトのcomments)にnewメソッドを呼び出すことで、掲示板に紐づいた@commentが取得できる
   end

   def edit
     
   end

   def update
     if @board.update(board_params)
       redirect_to @board
     else
      redirect_to :back, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
   end

   def destroy
   	 #特定のIDに対して行うアクションなので、findがいる
   	 @board.delete

   	 redirect_to boards_path, flash: { notice: "『#{@board.title}』の掲示板を削除しました" } 
   end

   private

   def board_params
     params.require(:board).permit(:name, :title, :body)
   end

   def set_target_board
   	 @board = Board.find(params[:id])
   end
 end
