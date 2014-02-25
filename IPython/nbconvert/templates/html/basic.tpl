{%- extends 'display_priority.tpl' -%}


{% block codecell %}
<div class="cell border-box-sizing code_cell">
{{ super() }}
</div>
{%- endblock codecell %}

{% block input_group -%}
<div class="input">
{{ super() }}
</div>
{% endblock input_group %}

{% block output_group %}
<div class="output_wrapper">
<div class="output">
{{ super() }}
</div>
</div>
{% endblock output_group %}

{% block in_prompt -%}
<div class="prompt input_prompt">
In&nbsp;[{{ cell.prompt_number }}]:
</div>
{%- endblock in_prompt %}

{% block empty_in_prompt -%}
<div class="prompt input_prompt">
</div>
{%- endblock empty_in_prompt %}

{# 
  output_prompt doesn't do anything in HTML,
  because there is a prompt div in each output area (see output block)
#}
{% block output_prompt %}
{% endblock output_prompt %}

{% block input %}
<div class="input_area box-flex1">
{{ cell.input | highlight2html(metadata=cell.metadata) }}
</div>
{%- endblock input %}

{% block output %}
<div class="output_area">
{%- if output.output_type == 'pyout' -%}
    <div class="prompt output_prompt">
    Out[{{ cell.prompt_number }}]:
{%- else -%}
    <div class="prompt">
{%- endif -%}
    </div>
{{ super() }}
</div>
{% endblock output %}

{% block markdowncell scoped %}
<div class="cell border-box-sizing text_cell">
<div class="input">
{{ self.empty_in_prompt() }}
<div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
{{ cell.source  | markdown2html | strip_files_prefix }}
</div>
</div>
</div>
</div>
{%- endblock markdowncell %}

{% block headingcell scoped %}
<div class="cell border-box-sizing text_cell">
<div class="input">
{{ self.empty_in_prompt() }}
<div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
{{ ("#" * cell.level + cell.source) | replace('\n', ' ')  | markdown2html | strip_files_prefix | add_anchor }}
</div>
</div>
</div>
</div>
{% endblock headingcell %}

{% block unknowncell scoped %}
unknown type  {{ cell.type }}
{% endblock unknowncell %}

{% block pyout -%}
<div class="box-flex1 output_subarea output_pyout">
{% block data_priority scoped %}
{{ super() }}
{% endblock %}
</div>
{%- endblock pyout %}

{% block stream_stdout -%}
<div class="box-flex1 output_subarea output_stream output_stdout">
<pre>
{{ output.text | ansi2html }}
</pre>
</div>
{%- endblock stream_stdout %}

{% block stream_stderr -%}
<div class="box-flex1 output_subarea output_stream output_stderr">
<pre>
{{ output.text | ansi2html }}
</pre>
</div>
{%- endblock stream_stderr %}

{% block data_svg -%}
{{ output.svg }}
{%- endblock data_svg %}

{% block data_html -%}
<div class="output_html rendered_html">
{{ output.html }}
</div>
{%- endblock data_html %}

{% block data_png %}
<img src="data:image/png;base64,{{ output.png }}"
{%- if 'metadata' in output and 'width' in output.metadata.get('png', {}) %}
width={{output.metadata['png']['width']}}
{%- endif %}
{%- if 'metadata' in output and 'height' in output.metadata.get('png', {}) %}
height={{output.metadata['png']['height']}}
{%- endif %}
>
{%- endblock data_png %}

{% block data_jpg %}
<img src="data:image/jpeg;base64,{{ output.jpeg }}"
{%- if 'metadata' in output and 'width' in output.metadata.get('jpeg', {}) %}
width={{output.metadata['jpeg']['width']}}
{%- endif %}
{%- if 'metadata' in output and 'height' in output.metadata.get('jpeg', {}) %}
height={{output.metadata['jpeg']['height']}}
{%- endif %}
>
{%- endblock data_jpg %}

{% block data_latex %}
{{ output.latex }}
{%- endblock data_latex %}

{% block pyerr -%}
<div class="box-flex1 output_subarea output_pyerr">
<pre>{{ super() }}</pre>
</div>
{%- endblock pyerr %}

{%- block traceback_line %}
{{ line | ansi2html }}
{%- endblock traceback_line %}

{%- block data_text %}
<pre>
{{ output.text | ansi2html }}
</pre>
{%- endblock -%}

{%- block data_javascript %}
<script type="text/javascript">
{{ output.javascript }}
</script>
{%- endblock -%}

{%- block display_data scoped -%}
<div class="box-flex1 output_subarea output_display_data">
{{ super() }}
</div>
{%- endblock display_data -%}
