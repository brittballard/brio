class JobCreationService
  def initialize(job_klass)
    @job_klass = job_klass
  end
  
  def create(params)
    @job_klass.create(params)
  end
end