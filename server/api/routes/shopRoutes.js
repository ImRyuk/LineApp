module.exports = function(app) {
    const shops = require('../controllers/shopController');

    // shop Routes

    app.route('/shops')
        .get(shops.list_all_shops)
        .post(shops.create_a_shop);

    app.route('/shops/:shopId')
        .get(shops.read_a_shop)
        .put(shops.update_a_shop)
        .delete(shops.delete_a_shop);

    app.route('/shops/waitTime/:shopId')
        .get(shops.waitTime);

    app.route('/shops/isOpen/:shopId')
        .get(shops.isOpen);

    app.route('/shops/hasReward/:shopId')
        .get(shops.hasReward);

    app.route('/shops/search/:searchString')
        .get(shops.search_shops);
};
