// Config
var qojl_data = "QuantumOptics.jl"; // ignore version by RegEx Replace
var qojlfft_data = "QuantumOptics.jl/fft"; // ignore version by RegEx Replace
var qutip_data = "QuTiP";
var qutipcython_data = "QuTiP/cython";
var toolbox_data = "QuantumOpticsToolbox";

// Asign colors to different toolboxes
function chartcolors (type) {
	switch (type) {
		case qojl_data:
			return '#d66761';
			break;
		case qutip_data:
			return '#a87db6';
			break;
		case qutipcython_data:
			return '#666666';
			break;
		case toolbox_data:
			return '#6cac5b';
			break;
	}
}

// Nice readable names for different toolboxes
function chartnames (type) {
	switch (type) {
		case qojl_data:
			return 'QO.jl';
			break;
		case qutip_data:
			return 'QuTiP';
			break;
		case qutipcython_data:
			return 'QuTiP/cython';
			break;
		case toolbox_data:
			return 'QO Toolbox';
			break;
		default:
			return type;
	}
}

// Define CSS for Source Code Buttons
function btncss (type) {
	switch (type) {
		case qojl_data:
			return 'qojl';
			break;
		case qutip_data:
			return 'qutip';
			break;
		case qutipcython_data:
			return 'qutipc';
			break;
		case toolbox_data:
			return 'qotb';
			break;
	}
}

// Create Links to GitHub pages
function githublink (type, file) {
	base = 'https://github.com/https://github.com/JuliaDynamics/JuliaDynamicsDocumentation.jl-benchmarks/blob/master/benchmarks-';
	
	switch (type) {
		case qojl_data:
			link = 'QuantumOptics.jl/'+file+'.jl';
			break;
		case qutip_data:
			link = 'QuTiP/'+file+'.py';
			break;
		case qutipcython_data:
			link = 'QuTiP/'+file+'_cython.py';
			break;
		case toolbox_data:
			link = 'QuantumOpticsToolbox/bench_'+file+'.m';
			break;
	}
	
	return base + link;
}

// Rearrange data structure
function rearrange (jsondata) {
		d = [];

	for (var i in jsondata) {
		xval = jsondata[i].N;
		yval = jsondata[i].t;
		d.push({x: xval, y: yval});
	}

	return d;
}

// Dynamical object with all the plot parameters and settings
function chartconfig (data, charttitle) {
	configobj = {
	    type: 'line',
	    data: {
	        datasets: []
	    },
	    options: {
		    title: {
			    display: true,
				text: charttitle,
				fontSize: 14,
				fontStyle: 'normal',
				fontColor: "#333333"
				},
	        scales: {
	            xAxes: [{
		            type: 'linear',
		            position: 'bottom',
	                scaleLabel: {
		                display: true,
		                labelString: 'Hilbert-Space Dimension',
		                fontSize: 14,
						fontStyle: 'normal',
	                }
	            }],
	            yAxes: [{
	                scaleLabel: {
		                display: true,
		                labelString: 'Elapsed Time [seconds]',
		                fontSize: 14,
						fontStyle: 'normal',
	                }

	            }]
	        }
	    }
	};
	
	for (dataname in data) {
		new_dataset = {
			       label: chartnames(dataname),
			       data: rearrange(data[dataname]),
			       fill: false,
			       lineTension: 0,
			       borderWidth: 3.0,
			       borderColor: chartcolors (dataname),
			       backgroundColor: chartcolors (dataname)
		        };
		
		configobj.data.datasets.push(new_dataset);
		}
	
	
	
	return configobj;
}


// Dynamically generate buttons that link to source cod
function sourceButtons (plot, data) {
	var buttons = '<div class="btn-group btn-group-sm">';
	
	buttons = buttons + '<a style="cursor: default;" class="btn btn-default"><i class="fa fa-github"></i> View Source Code</a>';
	
	file = plot.attr('id');
	
	for (d in data) {
		buttons = buttons+ '<a href="'+githublink(d, file)+'" class="btn btn-'+btncss(d)+'">'+chartnames(d)+'</a>';
	}
	
	buttons = buttons + '</div>';
	
	plot.parent().addClass('text-center');
	plot.after(buttons);
		
}

// Initialize plot array
var plot = [] ;

$('canvas').each(function (index) {
	 plot[index] = $(this);
	 
	 $.get('/benchmark-data/'+plot[index].attr('id')+'.json', function (data) {
	 
	 
	 data = data.replace(/QuantumOptics\.jl-\w*\/fft(?=")/g, 'QuantumOptics.jl/fft');
	 data = data.replace(/QuantumOptics.jl-\w*(?=")/g, 'QuantumOptics.jl');
	 data = data.replace(/QuTiP-[0-9.]*(?=")/g, 'QuTiP');
	 data = data.replace(/QuTiP-[0-9.]*\/cython(?=")/g, 'QuTiP/cython');
	 
	jsondata = $.parseJSON(data);
	 
	 // Leave out FFT Benchmarks for now
	  if (qojlfft_data in jsondata) {
	 	delete jsondata[qojlfft_data];
	 }
	 
	plot[index].attr('height', '180');	 
	new Chart(plot[index], chartconfig(jsondata, plot[index].data('title')));
	
	sourceButtons (plot[index], jsondata);
	
	}, 'text');
	
	
	
	
});

