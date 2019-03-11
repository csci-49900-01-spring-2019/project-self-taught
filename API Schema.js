var mongoose = require('mongoose');
var Schema = mongoose.Schema:
var FullName = new Schema(
    {
      first : String,
      last : String
    }
);
var User = new Schema(
{
  name : [fullName],
  username : {type: String, required: true},
  password : {type: String, required: true},
  email : {type: String, required: true},
  gender : {type: String, required: false},
  gradeLevel : {type: String, required: false},
  groups : [Group],
  myTest : {Test},
  friends: [{type: String, required: false}],
}
{
  timestamps:true
});
var Tags = new Schema(
  {
    tagName : String
  }
);
var Note = new Schema(
  {
    name : {type: String, required: true},
    creator : {type: String, required: true},
    ratings : [Rating],
    comments : [Comment],
    private : {type: boolean, required: true}
  } 
);
var Rating = new Schema(
    {
        user : [User],
        score : {type: int, required: true}
    }
):
var Comment = new Schema(
    {
        user : [User],
        data : {type: String, required: true}
    }
);
var Group = new Schema(
    {
        name : {type: String, required: false},
        messages : [Message],
    }
    {
        timestamp: true
    }
);
var Message = new Schema(
    {
        user : [User],
        content : {type: String, required: true},
    }
    {
        timestamp: true
    }
);
var Test = new Schema(
    {
        name : {type: String, required: true},
        questions : [Question],
        timeLimit : {type: int, required: false},
        user : [User],
        private : {type: boolean, required: false}
    }
);
var Question = new Schema(
    {
        content : {type: String, required: true},
        answer : {type: String, required: true}
    }
);
