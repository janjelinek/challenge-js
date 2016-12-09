import Ember from 'ember';
import RSVP from 'rsvp';

export default Ember.Route.extend({
    model(params) {

        var folder = this.get('store').query('audience-folder', { folder_id: params.folder_id }).then(function(folders) {
            return folders.get("firstObject");
        });

        return RSVP.hash({
            folders: this.get('store').query('audience-folder', { parent_id: params.folder_id }),
            folder: folder,
            audience: this.get('store').query('audience', { folder_id: params.folder_id }),
        });
    }
});
