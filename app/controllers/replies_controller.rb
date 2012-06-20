class RepliesController < ApplicationController
  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    #@reply = Reply.find(params[:id])
    @reply = Reply.new
    @micropost_id = params[:id]
    render 'replies/new.html.erb'
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @reply = Reply.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.json
  def create

    #@reply = current_user.microposts.reply.build(params[:reply])
    @reply = Reply.new(params[:reply])
    @reply.micropost_id = params[:micropost_id]
    @reply.micropost.replies.build()

    if @reply.save
      post_record = Micropost.find(params[:micropost_id])

      # keep a count of replies so we can order posts by popularity
      if post_record.reply_cnt == nil
        post_record.reply_cnt = 1
      else
        post_record.reply_cnt = post_record.reply_cnt + 1
      end
      post_record.save

      flash[:success] = "Reply created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'sessions/new'
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to replies_url }
      format.json { head :no_content }
    end
  end
end
