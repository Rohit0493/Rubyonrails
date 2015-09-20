require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "THIS IS MY todo list"
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end	
	
	it "redirects to the todo lists index page on sucess" do
		
		create_todo_list
		
		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title " do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: ""
		
		visit "/todo_lists"
		expect(page).to_not	have_content("This is what I am doing today.")
	end	


	it "displays an error when the todo list has a title less than 3 characters" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not	have_content("This is what I am doing today.")
	end	

	it "displays an error when the todo list has no Description" do
		expect(TodoList.count).to eq(0)

		create_todo_list title:"Grocery list" ,description: ""
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not	have_content("Grocery list")
	end	

	it "displays an error when the todo list has some Description" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: "Grocery" ,description: "Food"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not	have_content("Grocery list")
	end	
end	