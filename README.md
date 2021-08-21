### accept_nested_attributes_for を使用した、データの一括更新
Ruby on RailsにてTodoアプリを作成中。カテゴリモデルとTodoモデルの親子関係で作成しています。

### 発生している問題・エラーメッセージ

edit.html.erbで入力した値をtodoescontrollerのupdateアクションで受け取り、レコードの一括更新を行いたい。しかし、edit.html.erbでから値を送信すると、入力内容が新規レコードとしてデータベースに保存され、レコードの数が等比的に増えていってしまいます。

### 該当のソースコード
Ruby on Rails 6.1.4
```
#Category.rb

class Category < ApplicationRecord
    has_many :todos
    accepts_nested_attributes_for :todos, reject_if: :all_blank, allow_destroy: true
end
```

```
#TodoesController
class TodoesController < ApplicationController

  before_action :set_current_user
  
  def new
    @category = Category.new
    4.times { @category.todos.build }
  end

  def create
    @category = Category.new(
      category_params,
    )
    @category.save
    redirect_to("/categories/index")
  end

  def edit
    @category = Category.new
    @category.todos.build
    @category_name = Category.find(params[:id])
    @todoes = Todo.where(category_id: @category_name.id)
  end

  def update
    @category = Category.where(params[:id])
    @category.update(update_category_params)
    redirect_to("/categories/index")
  end
  
  private
    def category_params
      params.require(:category).permit(:kind, todos_attributes: [:id, :title, :content, :deadline, :_destroy])
    end

    def update_category_params
      params.require(:category).permit(:kind, todos_attributes: [:id, :title, :content, :deadline, :category_id, :_destroy])
    end
end

class Category < ApplicationRecord
    has_many :todos
    accepts_nested_attributes_for :todos, reject_if: :all_blank, allow_destroy: true
end
```
```
<%= form_for @category, url: "/todoes/#{@category_name.id}/update" do |f| %>
        <%= f.label "カテゴリー名"%>
        <%= f.text_field :kind, value: @category_name.kind %>
    <ul>
    <% @todoes.each do |todo| %>
        <%= f.fields_for :todos do |todos_form| %>
            <li>
                <%= todos_form.label "タイトル" %>
                <%= todos_form.text_field :title, value: todo.title %>

                <%= todos_form.label "詳細" %>
                <%= todos_form.text_field :content, value: todo.content %>
                
                <%= todos_form.label "締め切り" %>
                <%= todos_form.text_field :deadline, value: todo.deadline %>
            </li>
        <% end %>
    <% end %>
    </ul>
    <%= f.submit "Update Tasks" %>
<% end %>
```
### 試したこと

Qiitaなどで調べた結果、allow_destoryと:_destroyを有効にする、update_onlyを親クラスに記述するなどの解決案が見つかりましたが、結果変わらずといった形です。

### 補足情報（FW/ツールのバージョンなど）

ここにより詳細な情報を記載してください。