# Basics
CHAPTER_01 += chapter01_introduction.md
CHAPTER_01 += ../../general/pandoc_page_break.txt

CHAPTER_02 += chapter02_getting_started.md
CHAPTER_02 += ../code/code_what_is_programming.md

pagebreak = ../../general/pandoc_page_break.txt

CHAPTERS = part01_firstpart.md $(pagebreak) $(CHAPTER_01) 

graph_to_png = dot -Tpng ./graphviz/$(1).dot -o ./pictures/$(1).png
grap_convert = gvpr -c '$(1)' ./graphviz/$(2).dot | dot -Tpng -o ./pictures/$(3).png

all:
	cd nl/chapter && pandoc ../title.txt $(CHAPTERS) -o ../../dist/cursus.epub --epub-stylesheet ../../base.css --epub-cover-image=../front_page.jpg\

	cd nl/chapter && pandoc ../title.txt $(CHAPTERS) -o ../../dist/cursus.html  --self-contained -s -S --toc --toc-depth=2	-c ../../github-pandoc.css

	cd nl/chapter && pandoc -S ../title.txt $(CHAPTERS) --latex-engine=xelatex -o ../../dist/cursus.pdf 	-c ../../github-pandoc.css

	zip dist/cursus.zip dist/cursus.epub dist/cursus.html dist/cursus.pdf

labos:
	cd nl/labo && pandoc  \
labo_header.md $(pagebreak) example_labosmd $(pagebreak) -o ../../dist/labos.epub

		cd nl/labo && pandoc  \
			labo_header.md $(pagebreak) x86_statements.md $(pagebreak) x86_loops_and_conditionals.md $(pagebreak) avr_x86_shift_operators.md $(pagebreak) avr_arduino_firsttime.md $(pagebreak) avr_arduino_more_complex_in_group.md $(pagebreak) labo_functies_en_loop.md $(pagebreak) x86_arrays.md $(pagebreak) avr_arduino_adc.md $(pagebreak) labo_loops_extended.md labo_i2c.md\
		-o ../../dist/labos.html

clean:
	rm dist/cursus.epub

build_graphs:
	#$(foreach dotfile,$(wildcard ./graphviz/*.dot),${call graph_to_pnge,$(dotfile)})
	${call graph_to_png,"code_hierachy_of_statements"}
	${call graph_to_png,"orientation_digital_courses"}
	${call graph_to_png,"intro_in_c_2_variables_1"}
	${call graph_to_png,"intro_in_c_2_variables_2"}
	${call graph_to_png,"assembly_build"}
	${call graph_to_png,"compile_build"}
	gvpr -c 'N[name=="simple_statement" | name=="assignment" | name=="function_call"]{color="blue"}' ./graphviz/code_hierachy_of_statements.dot | dot -Tpng -o ./pictures/code_focus_on_simple_statements.png
	gvpr -c 'N[name=="block_statement" | name=="conditional_statement"]{color="blue"}' ./graphviz/code_hierachy_of_statements.dot | dot -Tpng -o ./pictures/code_focus_on_conditions.png
