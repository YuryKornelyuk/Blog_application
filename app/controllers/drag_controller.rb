class DragController < ApplicationController

  def project
    @project = Project.find(drag_project_params[:id])
    @project.insert_at(drag_project_params[:position].to_i + 1) # Добавляем единицу,
    # поскольку в JS ID-шки начинаются с 0, а в Ruby с 1
  end

  private

  def drag_project_params
    params.require(:resource).permit(:id, :position)
  end
end
