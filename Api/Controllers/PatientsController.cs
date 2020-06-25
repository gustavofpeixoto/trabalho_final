using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Data;
using Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientsController : ControllerBase
    {
        private readonly ApiContext _context;

        public PatientsController(ApiContext context)
        {
            _context = context;
        }
        /// <summary>
        /// Retorna todos pacientes.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP GET para recuperar os pacientes cadastrados.
        /// </remarks>
        /// <returns></returns>
        [HttpGet("Patients")]
        public async Task<IActionResult> GetPatients()
        {
            List<Patient> result = await _context.Patients.ToListAsync();
            return Ok(result);
        }

        /// <summary>
        /// Retorna o paciente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP GET para recuperar o paciente com base no ID fornedico.
        /// </remarks>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("Patient/{id}")]
        public async Task<IActionResult> GetPatient(Guid id)
        {
            Patient result = await _context.Patients.FirstOrDefaultAsync(p => p.Id == id);
            return Ok(result);
        }

        /// <summary>
        /// Cria um novo paciente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP POST para criar novo paciente.
        /// </remarks>
        /// <param name="patient"></param>
        /// <returns></returns>
        [HttpPost("Patient")]
        public async Task<IActionResult> Create(Patient patient)
        {
            if (!ModelState.IsValid) return BadRequest("Erro ao criar o registro");
            try
            {
                await _context.Patients.AddAsync(patient);
                await _context.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

            return Ok();
        }

        /// <summary>
        /// Atualiza um paciente existente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP POST para atualizar paciente existente. 
        /// </remarks>
        /// <param name="patient"></param>
        /// <returns></returns>
        [HttpPut("Patient")]
        public async Task<IActionResult> Update(Patient patient)
        {
            if (!ModelState.IsValid) return BadRequest("Erro ao atualizar o registro");

            Patient patientDb = await _context.Patients.FirstOrDefaultAsync(p => p.Id == patient.Id);

            if (patientDb != null)
            {
                patientDb.Active = patient.Active;
                patientDb.Address = patient.Address;
                patientDb.Name = patient.Name;
                patientDb.YearsOld = patient.YearsOld;

                _context.Patients.Update(patientDb);
                await _context.SaveChangesAsync();
            }
            else return NotFound();

            return Ok();
        }

        /// <summary>
        /// Remove um paciente existente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP DELETE para remover paciente existente.
        /// </remarks>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            Patient patientToDelete = new Patient { Id = id };
            _context.Patients.Remove(patientToDelete);
            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}