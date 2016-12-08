using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormsApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private List<Dog> originalDogs = new List<Dog>()
        {
            new Dog() {ID = 1, Name = "Fido", Owner= "Frank", Gender = "Male"},
            new Dog() {ID = 2,  Name = "Spike", Owner="Penelope", Gender = "Female"},
            new Dog() {ID = 3, Name="Bubbles", Owner="Dave" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {   
                LoadDogs();
            }
        }

        private void LoadDogs()
        {
            Session["Dogs"] = originalDogs;
        }


        public IEnumerable<Dog> GetDogs()
        {
            var dogs = Session["Dogs"] as List<Dog> ?? new List<Dog>();
            return dogs;
        }

        public IEnumerable GetGenderOptions()
        {
            var list = new Dictionary<string, string>();
            list.Add("Select Gender", "");
            list.Add("Male", "Male");
            list.Add("Female", "Female");

            return list;
        }

        public void InsertNewDog(Dog dog)
        {
            var dogs = Session["Dogs"] as List<Dog> ?? new List<Dog>();
            dog.ID = dogs.Max(d => d.ID) + 1;

            dogs.Add(dog);
            DataBind();
        }

        public void DeleteDog(int id)
        {
            Debug.WriteLine($"Dog ID: {id}");
            var dogs = Session["Dogs"] as List<Dog> ?? new List<Dog>();

            var dog = dogs.FirstOrDefault(d => d.ID == id);

            dogs.Remove(dog);
            DataBind();
        }

        public void UpdateDog(int id, string owner, string name, string gender)
        {
            var dropDownList = DogGrid.FindControl("GenderDropDownList");

            List<Dog> dogs = Session["Dogs"] as List<Dog> ?? new List<Dog>();

            var dog = dogs.FirstOrDefault(d => d.ID == id);
            dog.Owner = owner;
            dog.Name = name;
            dog.Gender = gender;

            DogGrid.DataBind();
        }

        protected void DogGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Insert")
            {
                var ownerTextBox = (TextBox) DogGrid.FooterRow.FindControl("AddOwnerTextBox");
                var dogTextBox = (TextBox) DogGrid.FooterRow.FindControl("AddNameTextBox");
                var gender = (DropDownList) DogGrid.FooterRow.FindControl("AddGenderDropDownList");
                var dog = new Dog()
                {
                    Owner = ownerTextBox.Text,
                    Name = dogTextBox.Text,
                    Gender = gender.SelectedValue ?? ""
                };

                InsertNewDog(dog);
            }
        }
    }

    public class Dog
    {
        public int ID { get; set; }
        public string Owner { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
    }
}