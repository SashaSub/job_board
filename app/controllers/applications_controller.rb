class ApplicationsController < ApplicationController   
    before_action :authenticate_user!
    before_action :set_application, only: %i[ show edit update destroy ]

    def index
        @applications = Application.all        
    end

    def show
      #@job = Job.find(params[:application][:job_id])
    end

    def new
        @application = Application.new
    end

    def edit
        #@job = Job.find(params[:application][:job_id])
    end     

    def create  
      @user = current_user
      @job = Job.find(params[:application][:job_id])

        respond_to do |format|
          application = Application.find_by(user_id: @user, job_id: @job.id)

          if application
            format.html { redirect_to jobs_path, notice: "You've already applied for this job!" }
          else
            @application = Application.new(application_params)
            @application.user = current_user

            if @application.save!
              format.html { redirect_to jobs_path, notice: 'Thank you, we received your application.' }
            else
              format.html { redirect_to job_path(@job.id), notice: 'Application was not sent.' }
            end
          end
        end 
    end

    def update
      respond_to do |format|
        if @application.update(application_params)
          format.html { redirect_to applications_path, notice: "Application was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }           
        end
      end
    end
    
      # DELETE /jobs/1 or /jobs/1.json
    def destroy
      @application.destroy
    
      respond_to do |format|
        format.html { redirect_to applications_url, notice: "Application was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_application
      @application = Application.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:content, :job_id, :user_id)
    end
        
end
