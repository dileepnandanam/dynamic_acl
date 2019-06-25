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

Complex actions over derived/dynamic states of resource

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
And you can uncheck the cell in acl matrix under "delete_another's_article" for each states and for students.
      
You can also play with dynamic/derived states for artiles. For ex. if you want to prevent deletion of article with comments which is created by the current_user himself, like

.. code:: bash
    #article.rb
    def self.states
        [
            "with_comments",
            "archived",
            "published",
           "new"
        ]
    end
    
    def state
        @article.comments.count > 0 ? "with_comments" : @article.state
    end
And you can uncheck delete action in acl matrix under state "with_comments" corresponding to students.
