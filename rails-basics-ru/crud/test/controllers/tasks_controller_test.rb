require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = Task.create(
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence,
      status: %w[Pending InProgress Completed].sample,
      creator: Faker::Name.name,
      performer: Faker::Name.name,
      completed: [true, false].sample
    )
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should show task' do
    task = Task.last
    get task_url(task)
    assert_response :success
  end

  test 'should edit task' do
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should update task' do
    patch task_url(@task), params: {
      task: {
        name: 'Updated Name',
        description: 'Updated Description',
        status: 'Completed',
        performer: 'Updated Performer'
      }
    }
    assert_redirected_to task_url(@task)
    @task.reload
    assert_equal 'Updated Name', @task.name
    assert_equal 'Updated Description', @task.description
    assert_equal 'Completed', @task.status
    assert_equal 'Updated Performer', @task.performer
    assert_redirected_to task_url(Task.last)
  end

  test 'should destroy task' do
    assert_difference 'Task.count', -1 do
      delete task_url(@task)
    end
    assert_redirected_to tasks_url
  end

  test 'should create a task' do
    assert_difference 'Task.count', 1 do
      post tasks_url, params: {
        task: {
          name: Faker::Lorem.word,
          description: Faker::Lorem.sentence,
          status: 'Pending',
          creator: Faker::Name.name,
          performer: Faker::Name.name,
          completed: false
        }
      }
    end
    assert_redirected_to task_url(Task.last)
  end
end
