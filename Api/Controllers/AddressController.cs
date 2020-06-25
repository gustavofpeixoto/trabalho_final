using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Api.Data;
using Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        private readonly ApiContext _context;
        public AddressController(ApiContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Retorna todos Endereços.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP GET para recuperar os endereços cadastrados.
        /// </remarks>
        /// <returns></returns>
        [HttpGet("Addresses")]
        public async Task<IActionResult> GetAddresses()
        {
            List<Address> result = await _context.Addresses.ToListAsync();
            return Ok(result);
        }

        /// <summary>
        /// Retorna o endereço.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP GET para recuperar o endereço com base no ID fornecido.
        /// </remarks>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("Address/{id}")]
        public async Task<IActionResult> GetAddress(Guid id)
        {
            Address result = await _context.Addresses.FirstOrDefaultAsync(a => a.Id == id);
            return Ok(result);
        }

        /// <summary>
        /// Cria um novo endereço.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP POST para criar novo endereço.
        /// </remarks>
        /// <param name="address"></param>
        /// <returns></returns>
        [HttpPost("Address")]
        public async Task<IActionResult> Create(Address address)
        {
            if (!ModelState.IsValid) return BadRequest("Erro ao criar o registro");
            try
            {
                await _context.Addresses.AddAsync(address);
                await _context.SaveChangesAsync();
            }
            catch (Exception e)
            {

                return BadRequest(e.Message);
            }

            return Ok();
        }

        /// <summary>
        /// Atualiza um endereço existente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP POST para atualizar endereço existente. 
        /// </remarks>
        /// <param name="address"></param>
        /// <returns></returns>
        [HttpPut("Address")]
        public async Task<IActionResult> Update(Address address)
        {
            if (!ModelState.IsValid) return BadRequest("Erro ao atualizar o registro");

            Address addressDb = await _context.Addresses.FirstOrDefaultAsync(a => a.Id == address.Id);

            if (addressDb != null)
            {
                addressDb.AddressComplement = address.AddressComplement;
                addressDb.City = address.City;
                addressDb.Neighborhood = address.Neighborhood;
                addressDb.Number = address.Number;
                addressDb.PatientId = address.PatientId;
                addressDb.PublicPlace = address.PublicPlace;
                addressDb.State = address.State;
                addressDb.ZipCode = address.ZipCode;

                _context.Addresses.Update(addressDb);
                await _context.SaveChangesAsync();
            }
            else return NotFound();

            return Ok();
        }

        /// <summary>
        /// Remove um endereço existente.
        /// </summary>
        /// <remarks>
        /// Este método utiliza o verbo HTTP DELETE para remover endereço existente.
        /// </remarks>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            Address addressToDelete = new Address { Id = id };

            _context.Addresses.Remove(addressToDelete);
            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}