import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('folders');
  this.route('folder', { path: '/folder/:folder_id' });
});

export default Router;
