require 'test_helper'

class PortalsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Portal.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Portal.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Portal.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to portal_url(assigns(:portal))
  end
  
  def test_edit
    get :edit, :id => Portal.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Portal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Portal.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Portal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Portal.first
    assert_redirected_to portal_url(assigns(:portal))
  end
  
  def test_destroy
    portal = Portal.first
    delete :destroy, :id => portal
    assert_redirected_to portals_url
    assert !Portal.exists?(portal.id)
  end
end
