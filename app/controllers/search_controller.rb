class SearchController < ApplicationController


	def search
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@how = params["search"]["how"]
		@datas = search_for(@model, @content, @how)
	end

	  private
    def search_for(model, content, how)
      if model == 'user'
        if how == 'perfect'
          User.where(name: content)
        elsif how == 'forward'
          User.where('name LIKE ?', content+'%')
          # 前方一致
          # name Like ?  nameカラムを検索
          # where 与えられた条件を全て消す
        elsif how == 'backward'
          User.where('name LIKE ?', '%'+content)
          # 後方一致
        else
          User.where('name LIKE ?', '%'+content+'%')
          # 部分一致
        end
      elsif model == 'book'
        if how == 'perfect'
          Book.where(title: content)
        elsif how == 'forward'
          Book.where('title LIKE ?', content+'%')
        elsif how == 'backward'
          Book.where('title LIKE ?', '%'+content)
        else
          Book.where('title LIKE ?', '%'+content+'%')
        end
      end
    end

	# private
	# def match(model, content)
	# 	if model == 'user'
	# 		User.where(name: content)
	# 	elsif model == 'book'
	# 		Book.where(title: content)
	# 	end
	# end

	# def forward(model, content)
	# 	if model == 'user'
	# 		User.where("name LIKE ?", "#{content}%")
	# 	elsif model == 'book'
	# 		Book.where("title LIKE ?", "#{content}%")
	# 	end
 #    end

 #    def backward(model, content)
 #    	if model == 'user'
 #    		User.where("name LIKE ?", "%#{content}")
 #        elsif model == 'book'
 #        	Book.where("title LIKE ?", "%#{content}")
 #        end
 #    end

 #    def partical(model, content)
 #    	if model == 'user'
 #    		User.where("name LIKE ?", "%#{content}%")
 #    	elsif model == 'book'
 #    		Book.where("title LIKE ?", "%#{content}%")
 #    	end
 #    end

 #    def search_for(how, model, content)
 #    	case how
 #    	when 'match'
 #    		match(model, content)
 #    	when 'forward'
 #    		forward(model, content)
 #    	when 'backward'
 #    		backward(model, content)
 #    	when 'partical'
 #    		partical(model, content)
 #    	end
 #    end
end
