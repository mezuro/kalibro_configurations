# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Adds the method create_ranges to Ruby's super class
class Array
  def create_ranges(metric_configuration_id)
    self.each do |range_hash|
      KalibroRange.create(range_hash.merge(
        {metric_configuration_id: metric_configuration_id}))
    end
  end
end

###############################################################################
########################### Reading Group & Readings ##########################
###############################################################################

scholar =  ReadingGroup.create(name: "Scholar", description: <<-END
This group imitates school grades and attributes generic labels from 'Terrible' (grade 0) to 'Excellent' (grade 10).
The colors vary in wave length with the grades, ranging from red to green (between them are tones of orange and yellow).
END
)

readings = {
  terrible:       { label: "Terrible", grade: 0.0, color: "FF0000"},
  bad:            { label: "Bad", grade: 1.25, color: "FF4000" },
  worrying:       { label: "Worrying", grade: 2.5, color: "FF8000"},
  unsatisfactory: { label: "Unsatisfactory", grade: 3.75, color: "FFC000" },
  regular:        { label: "Regular", grade: 5, color: "FFFF00" },
  satisfactory:   { label: "Satisfactory", grade: 6.25, color: "C0FF00" },
  good:           { label: "Good", grade: 7.5, color: "80FF00" },
  very_good:      { label: "Very Good", grade: 8.75, color: "40FF00" },
  excellent:      { label: "Excellent", grade: 10, color: "00FF00" }
}.map { |k, v|
  [k, Reading.create(v.merge({reading_group_id: scholar.id}))]
}.to_h

###############################################################################
########################### Java/C/C++ Configuration ##########################
###############################################################################

first_configuration = KalibroConfiguration.create(name: "First Configuration", description: <<-END
Configuration proposed as starting point for C, C++ and Java. From Morais' master text.
END
)

acc = NativeMetricSnapshot.create(
  name: "Afferent Connections per Class (used to calculate COF - Coupling Factor)",
  description: "", code: "acc", metric_collector_name: "Analizo",
  scope: "CLASS")

acc_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: acc.id, weight: 2.0, aggregation_form: "MEAN",
  reading_group_id: scholar.id, kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 2, comments: "", reading_id: readings[:excellent].id },
  { beginning: 2, end: 7, comments: "", reading_id: readings[:good].id },
  { beginning: 7, end: 15, comments: "", reading_id: readings[:regular].id },
  { beginning: 15, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "A classe possui muitas dependências. Tente seguir o princípio de responsabilidade única. Talvez seja necessário reduzir a interface das classes utilizadas."
  }
].create_ranges(acc_metric_configuration.id)

###############################################################################

accm = NativeMetricSnapshot.create(
  name: "Average Cyclomatic Complexity per Method", description: "",
  code: "accm", metric_collector_name: "Analizo", scope: "CLASS")

accm_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: accm.id, weight: 2.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 3, comments: "", reading_id: readings[:excellent].id },
  { beginning: 3, end: 5, comments: "", reading_id: readings[:good].id },
  { beginning: 5, end: 7, comments: "", reading_id: readings[:regular].id },
  { beginning: 7, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Os métodos estão muito “pesados”. Tente quebrá-los em métodos menores e menos complexos. Evite longos “switches”, ou vários laços aninhados no mesmo método."
  }
].create_ranges(accm_metric_configuration.id)

###############################################################################

amloc = NativeMetricSnapshot.create(
  name: "Average Method Lines of Code", description: "", code: "amloc", metric_collector_name: "Analizo",
  scope: "CLASS")

amloc_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: amloc.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 8, comments: "", reading_id: readings[:excellent].id },
  { beginning: 8, end: 19, comments: "", reading_id: readings[:good].id },
  { beginning: 19, end: 37, comments: "", reading_id: readings[:regular].id },
  { beginning: 37, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Os métodos estão muito longos. Tente quebrá-los em métodos menores, cada um no seu nível de abstração. Forte candidato a novo método é o código em maior aninhamento."
  }
].create_ranges(amloc_metric_configuration.id)

###############################################################################

anpm = NativeMetricSnapshot.create(
  name: "Average Number of Parameters per Method", description: "", code: "anpm", metric_collector_name: "Analizo",
  scope: "CLASS")

anpm_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: anpm.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 2, comments: "", reading_id: readings[:excellent].id },
  { beginning: 2, end: 3, comments: "", reading_id: readings[:good].id },
  { beginning: 3, end: 5, comments: "", reading_id: readings[:regular].id },
  { beginning: 5, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Os métodos estão recebendo muitos parâmetros. Conjuntos de parâmetros parecidos sugerem a criação de uma classe contendo esses dados, e transferência dos métodos para essa classe."
  }  
].create_ranges(anpm_metric_configuration.id)

###############################################################################

dit = NativeMetricSnapshot.create(
  name: "Depth of Inheritance Tree", description: "", code: "dit", metric_collector_name: "Analizo", scope: "CLASS")

dit_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: dit.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 2, comments: "", reading_id: readings[:excellent].id },
  { beginning: 2, end: 4, comments: "", reading_id: readings[:good].id },
  { beginning: 4, end: 6, comments: "", reading_id: readings[:regular].id },
  { beginning: 6, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Talvez o mecanismo de herança esteja sendo utilizado em demasia. Sempre que fizer sentido, prefira composição à herança."
  }
].create_ranges(dit_metric_configuration.id)

###############################################################################

nom = NativeMetricSnapshot.create(
  name: "Number of Methods", description: "", code: "nom", metric_collector_name: "Analizo", scope: "CLASS")

nom_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: nom.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 10, comments: "", reading_id: readings[:excellent].id },
  { beginning: 10, end: 17, comments: "", reading_id: readings[:good].id },
  { beginning: 17, end: 27, comments: "", reading_id: readings[:regular].id },
  { beginning: 27, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Muitos métodos em uma só classe a torna mais difícil de entender. Talvez o princípio da responsabilidade única esteja sendo violado. Talvez alguns métodos não sejam necessários."
  }
].create_ranges(nom_metric_configuration.id)

###############################################################################

npa = NativeMetricSnapshot.create(
  name: "Number of Public Attributes", description: "", code: "npa", metric_collector_name: "Analizo", scope: "CLASS")

npa_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: npa.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 1, comments: "", reading_id: readings[:excellent].id },
  { beginning: 1, end: 2, comments: "", reading_id: readings[:good].id },
  { beginning: 2, end: 3, comments: "", reading_id: readings[:regular].id },
  { beginning: 3, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Em linguagens orientadas a objetos, atributos públicos são uma aberração e devem ser evitados ao máximo. Esconda os atributos e forneça métodos para controlar o acesso a eles."
  }
].create_ranges(npa_metric_configuration.id)

###############################################################################

sc = NativeMetricSnapshot.create(
  name: "Structural Complexity", description: "", code: "sc", metric_collector_name: "Analizo", scope: "CLASS")

sc_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: sc.id, weight: 4.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: first_configuration.id)

[
  { beginning: 0, end: 12, comments: "", reading_id: readings[:excellent].id },
  { beginning: 12, end: 28, comments: "", reading_id: readings[:good].id },
  { beginning: 28, end: 51, comments: "", reading_id: readings[:regular].id },
  { beginning: 51, end: Float::INFINITY, reading_id: readings[:worrying].id,
    comments: "Complexidade estrutural é um fator de risco. Verifique se a classe pode ser dividida em classes menores e mais coesas. Classes frutos dessa divisão tendem a ser menos acopladas."
  }
].create_ranges(sc_metric_configuration.id)

###############################################################################
############################## Ruby Configuration #############################
###############################################################################

ruby_configuration = KalibroConfiguration.create(name: "Ruby Configuration", description: "Example Ruby Configuration")

flog = NativeMetricSnapshot.create(
  name: "Pain", code: "flog", metric_collector_name: "MetricFu", scope: "METHOD",
  description: "Flog mede a tortuosidade do código-fonte. Quanto mais doloroso e difícil de testar, maior a pontuação, baseando-se na métrica ABC e boas práticas de Ruby. Extraído do blog do autor da métrica: http://jakescruggs.blogspot.com.br/2008/08/whats-good-flog-score.html"
)

flog_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: flog.id, weight: 3.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: ruby_configuration.id)

[
  { beginning: 0, end: 10, comments: "", reading_id: readings[:excellent].id },
  { beginning: 10, end: 20, comments: "", reading_id: readings[:good].id },
  { beginning: 20, end: 40, comments: "", reading_id: readings[:satisfactory].id },
  { beginning: 40, end: 60, comments: "", reading_id: readings[:regular].id },
  { beginning: 60, end: 100, comments: "", reading_id: readings[:worrying].id },
  { beginning: 100, end: Float::INFINITY, comments: "", reading_id: readings[:terrible].id }
].create_ranges(flog_metric_configuration.id)

###############################################################################

saikuro = NativeMetricSnapshot.create(
  name: "Cyclomatic Complexity", code: "saikuro", metric_collector_name: "MetricFu", scope: "METHOD",
  description: "Cyclomatic complexity is a graphical measurement of the number of possible paths through the normal flow of a program"
)

saikuro_metric_configuration = MetricConfiguration.create(
  metric_snapshot_id: saikuro.id, weight: 1.0, aggregation_form: "MEAN", reading_group_id: scholar.id,
  kalibro_configuration_id: ruby_configuration.id)

[
  { beginning: 0, end: 3, comments: "", reading_id: readings[:excellent].id },
  { beginning: 3, end: 5, comments: "", reading_id: readings[:good].id },
  { beginning: 5, end: 7, comments: "", reading_id: readings[:regular].id },
  { beginning: 7, end: Float::INFINITY, comments: "", reading_id: readings[:worrying].id }
].create_ranges(saikuro_metric_configuration.id)

###############################################################################
