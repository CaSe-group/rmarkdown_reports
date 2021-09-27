/*
Process template.

Please replace {process-template} to e.g. abricate via find and replace

Replace the suffix ".input" to ".svg" if the result is a ready to use figure.
*/

process {process-template} {
        label 'ubuntu'  
    input:
        tuple val(name), path(data_input), path(markdown_template)
    output:
        tuple val(name), path("${name}_report_{process-template}.Rmd"), path("${name}_report_{process-template}.input")
    script:
        """
        # Rename input data to avoid collisions later
            cp ${data_input} ${name}_report_{process-template}.input

        # modify tool markdown with input name
            sed -e 's/#RESULTSENV#/${name}_report_{process-template}.input/g' \
                ${markdown_template} > ${name}_report_{process-template}.Rmd
        """
    stub:
        """
        cp ${data_input} ${name}_report_{process-template}.input

        sed -e 's/#RESULTSENV#/${name}_report_{process-template}.input/g' \
            ${markdown_template} > ${name}_report_{process-template}.Rmd
        """
}