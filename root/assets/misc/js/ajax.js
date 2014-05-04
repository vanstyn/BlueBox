function orderAjax(opt) {

  Ext.Ajax.request({
		url: '/api/order',
		params: {
		  loc_json: Ext.encode(opt.data),
      qty: opt.data.numBoxes
		},
		success: function(response,options) {
      opt.callback({success: true});
    },
		failure: function(response,options) {
      opt.callback({success: false});
    }
    
  });
  
}

function shipAjax(opt) {
  // Dummy
  opt.callback({success: true });
}

function retrieveAjax(opt) {
  // Dummy
  opt.callback({success: true });
}
      
