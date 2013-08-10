//to change default tooltip styles, the tooltip div has an id of flotTip (i.e. use #flotTip)

/**
 *  Options for different graphs
 *
 */

var flot_options_sin_cos = {
    series: {
        lines: {
            show: true,
            lineWidth: 4,
            steps: false
        },
        points: {
            show: true,
            radius: 4,
            fill: true
        }
    },
    legend: {
        position: 'ne'
    },
    custom_tooltip: true,
    use_both: true,
    xaxis: {
        mode: "time"
    },
    grid: {
        borderWidth: 2,
        hoverable: true
    }
};

var flot_options_vertical = {
    grid: {
        hoverable: true,
        borderWidth: 2
    },
    bars: {
        show: true,
        align: 'center',
        barWidth: 0.15
    },
    legend: {
        show: true
    },
    tooltip: true,
    tooltipOpts: {
        content: '%s: %y'
    }
};

//clone the vertical options, then make changes
var flot_options_horizontal = jQuery.extend({}, flot_options_vertical, {
    bars: {
        barWidth: 0.25,
        show: true,
        align: 'center'
    },
    tooltipOpts: {
        content: '%s: %x'
    }
});

var flot_options_line = {
    grid: {
        hoverable: true,
        borderWidth: 2
    },
    lines: {
        show: true,
        lineWidth: 4,
        steps: false,
        fillColor: {
            colors: [{
                    opacity: 0.1
                }, {
                    opacity: 0.5
                }]
        }
    },
    points: {
        show: true
    },
    xaxis: {
        tickDecimals: 0,
        tickSize: 1
    },
    tooltip: true,
    tooltipOpts: {
        content: '%s - %x: %y'
    }

};

var flot_options_pie = {
    series: {
        pie: {
            show: true,
            stroke: {
                width: 3
            }
        }
    },
    grid: {
        hoverable: true
    },
    tooltip: true,
    tooltipOpts: {
        content: '%s: %y'
    }
};

var flot_options_doughnut = jQuery.extend({}, flot_options_pie, {
    series: {
        pie: {
            show: true,
            innerRadius: 0.55,
            stroke: {
                width: 5
            }
        }
    }
});

function flot_line(placeholder_id, user_options, ad, da, data_set, labels) {
    var placeholder = $('#' + placeholder_id);
    var options = jQuery.extend({}, user_options);
    if (placeholder.length <= 0) {
        return false;
    }
    if (data_set === null || data_set === undefined) {
        data_set = [ad, da];
    }

    if (labels === null || labels === undefined) {
        labels = ["Users", "Products"];
    }

    var data = [];
    var total_data_set = data_set.length;
    for (var i = 0; i < total_data_set; i++) {
        if (data_set[i] !== undefined && labels[i] !== undefined) {
            var temp_data = {
                label: labels[i],
                data: data_set[i],
                lines: {
                    lineWidth: 3
                }
            };
            if (i === 0) {
                temp_data.lines.fill = true;
            }
            data.push(temp_data);
        }
    }

    $.plot(placeholder, data, options);
}