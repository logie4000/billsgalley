module RecipesHelper

  def add_ingredient_link(text, recipe)
#    recipe = Recipe.find(recipe_id)
    if (recipe && recipe.id)
      link_to(text, add_ingredient_recipe_path( recipe ), :remote => true, :method => :patch )
    else
      link_to(text, add_ingredient_row_recipes_path, :remote => true )
    end
  end

  def remove_ingredient_link(text, recipe)
    link_to(text, remove_ingredient_recipe_path( recipe ), :remote => true, :method => :patch)
  end

  def add_direction_link(text, recipe)
    if (recipe && recipe.id)
      link_to(text, add_direction_recipe_path( recipe ), :remote => true, :method => :patch )
    else
      link_to(text, add_direction_row_recipes_path, :remote => true )
    end
  end

  def remove_direction_link(text)
    link_to(text, remove_direction_recipe_path( recipe ), :remote => true, :method => :patch)
  end

  def setup_recipe(recipe)
    if (recipe.ingredients.empty?)
      recipe.ingredients.build()
    end

    if (recipe.directions.empty?)
      recipe.directions.build()
    end

    return recipe
  end

  def ingredient_placeholder_text
    return Ingredient.placeholder_text
  end

  def direction_placeholder_text
    return Direction.placeholder_text 
  end

  def author_fullname(author = nil)
    if (author)
      return "#{author.first_name} #{author.last_name}"
    else
      return "Anonymous"
    end
  end
end
