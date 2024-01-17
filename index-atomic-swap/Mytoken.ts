import { RecipientChanged, SecretHashChanged, TokensBurned, TokensClaimed } from '../../generated/MyToken/MyToken';
import { RecipientChange, SecretHashUpdate, TokenBurn, TokensClaim } from '../../generated/schema';

export function handleTokensClaimed(event: TokensClaimed): void {
  const entity = new TokensClaim(event.transaction.hash.toHex() + '-' + event.logIndex.toString());
  entity.secret = event.params.secret; // Assuming 'secret' is a string in the event
  entity.save();
}

export function handleTokensBurned(event: TokensBurned): void {
  const entity = new TokenBurn(event.transaction.hash.toHex() + '-' + event.logIndex.toString());
  entity.burner = event.params.burner;
  entity.amount = event.params.amount;
  entity.save();
}

export function handleRecipientChanged(event: RecipientChanged): void {
  const entity = new RecipientChange(event.transaction.hash.toHex() + '-' + event.logIndex.toString());
  entity.newRecipient = event.params.newRecipient;
  entity.save();
}

export function handleSecretHashChanged(event: SecretHashChanged): void {
  const entity = new SecretHashUpdate(event.transaction.hash.toHex() + '-' + event.logIndex.toString());
  entity.newSecretHash = event.params.newSecertHash; // Corrected the parameter name
  entity.save();
}
