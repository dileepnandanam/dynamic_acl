Dynamic Access Controll

dynamic_acl is a gem for access controll, which provides web view of an editable access controll matrix where user can give or take back permissions for each user type for each user action under specific state of resource 

To get started:

.. code:: bash

    #Gemfile
    gem 'dynamic_acl'

    #on command line
    rake dynamic_acl:install
    
    #example usage

    #user.rb
    def self.user_types
      [
        "admin",
        "student",
        "faculty"
      ]
    end
    
    def self.actions
        [
          "create",
          "edit",
          "update",
          "delete"
        ]
      end

    def user_type
      if admin?
        "admin"
      elsif student?
        "student"
      else
        "faculty"
      end
    end

    #article.rb
    def self.states
      [
        "new",
        "archived",
        "published"
        "hidden",
        "deleted"
      ]
    end

    #articles_controller.rb
    def create
      @article = Article.new(article_params)
      if current_user.can?('create', @article) #Assuming Article.new.state => "new"
        @article.save
      end
    end

Now your all set. Go to localhost:3000/dynamic_acl/<model_name>
ex. localhost:3000/dynamic_acl/article

screenshot: https://www.dropbox.com/s/2edzn8v2i8ip1c9/dynamic_acl.jpg?dl=0

If you have little more complicated access controll rules like student can't delete anothers article, you can define the action accordingly and set acl matrix like,

.. code:: bash

    #articles_controller.rb
    def delete
        @article = Article.find(params[:id])
        action = @article.user != current_user ? "delete_another's_article" : "delete_his_article"
        if current_user.can?(action, @article)
            @article.destroy
        end
    end
    
    #article.rb
    def self.actions
        [ 
          "delete_his_article",
          "delete_another's_article",
          "create",
          "edit",
          "update",
          "delete"
        ]
      end
      
  
