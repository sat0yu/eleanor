class ScriptsController < ApplicationController
  def index
    @script = Script.new
    @scripts = Script.eager_load(:speech).order(created_at: :desc)
  end

  def create
    @script = Script.new(script_params)

    if @script.save
      CreateSpeechWorker.perform_async(@script.reload.id)
      flash[:notice] = 'Script was successfully created.'
    else
      flash[:alert] = 'failed to create new script'
    end
    redirect_to action: :index
  end

  private

  def script_params
    params.require(:script).permit(:title, :body)
  end
end
