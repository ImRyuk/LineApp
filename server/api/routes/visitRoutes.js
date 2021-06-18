module.exports = function(app) {
    const shops = require('../controllers/visitController');

    // shop Routes

    app.route('/visits')
        .get(shops.list_all_visits)
        .post(shops.create_a_visit);

    app.route('/visits/:visitId')
        .get(shops.read_a_visit)
        .put(shops.update_a_visit)
        .delete(shops.delete_a_visit);
};
