const User = require('./user.schema');

const UserController = ({
    getUsers: function (req, res) {
        User.find({}).
        populate('history').
        then(response => {
            res.status(200).send(response);
        }).catch(err => {
            res.status(500).send(err);
        })
    },
    uploadUser: function (req, res) {
        const newUser = new User({
            name: req.body.name,
            email: req.body.email,
            password: req.body.password,
        });
        newUser.save().
        then(response => {
            console.log(response);
            res.status(200).send(response);
        }).catch(err => {
            console.log(err);
            res.status(500).send(err);
        })
    },
    getUserByEmail: function (req, res) {
        User.findOne({email: req.params.email}).
        then(response => {
            res.status(200).send(response);
        }).catch(err => {
            res.status(500).send(err);
        })
    }
});

module.exports = UserController;