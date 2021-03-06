require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload("../models/*")
also_reload("../controllers/*")
require_relative("../models/tag.rb")

#INDEX
get "/tags" do
  @tags = Tag.all()
  erb(:"tag/index")
end

#NEW
get "/tags/new" do
  erb(:"tag/new")
end

#CREATE
post "/tags/create" do
  @tag = Tag.new(params)
  @tag.save()
  redirect to("/tags")
end

#NEW FROM TRANSACTION
get "/tags/new/:id" do
  @transaction = Transaction.find(params["id"].to_i())
  erb(:"tag/new_from_trans")
end

#CREATE FROM TRANSACTION
post "/tags/create/:transaction_id" do
  @tag = Tag.new(params)
  @tag.save()
  params["tag_id"] = @tag.id()
  @trans_tag = TransTag.new(params)
  @trans_tag.save()
  redirect to("/transaction/#{@trans_tag.transaction_id}")
end

#SHOW
get "/tag/:id" do
  @tag = Tag.find(params["id"])
  erb(:"tag/show")
end

#EDIT
get "/tag/:id/edit" do
  @tag = Tag.find(params["id"])
  erb(:"tag/edit")
end

#UPDATE
post "/tag/:id/update" do
  @tag = Tag.new(params)
  @tag.update()
  redirect to("/tag/#{@tag.id()}")
end

#DELETE
post "/tag/:id/delete" do
  @tag = Tag.find(params["id"].to_i())
  @tag.delete()
  redirect to("/tags")
end
