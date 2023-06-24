package edu.escola.sistemaedu.registroaula.contrato;

import edu.escola.sistemaedu.registroaula.aluno.Aluno;
import edu.escola.sistemaedu.registroaula.curso.Curso;
import edu.escola.sistemaedu.registroaula.matricula.Matricula;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.*;

@Data
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@SequenceGenerator(sequenceName = "contratoSequence", name = "contrato_seq", allocationSize = 1)
public class Contrato {

    @Id
    private long contratoId;

	private String situacaoContrato;

	private String tipoContrato;

	private String contratante;

	private String modalidade;

	private String dataInicio;

	private String dataTermino;

	private Curso curso;

	private Aluno aluno;

	private Matricula matricula;

}